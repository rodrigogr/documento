<?php

namespace App\Services;

use App\Helpers\DataHelper;
use App\Models\Carteira;
use App\Models\Condominio;
use App\Models\ConfiguracaoCarteira;
use App\Models\ContaBancaria;
use App\Models\Imovel;
use App\Models\ParcelaBoleto;
use App\Models\Pessoa;
use App\Models\Recebimento;
use App\Models\Receita;
use App\PrintPdf;
use Illuminate\Support\Facades\Storage;

class BoletoServices
{
    public function gerarRemessa($configuracao_carteira){
        $condominio = Condominio::all()->first()->get();

        if(empty($condominio)){
            return response()->error('Necessário informar os dados do Cedente, verifique em Configurações->Condomínio.');
        }

        $codigo_banco = ContaBancaria::join('bancos','conta_bancarias.idbanco','=','bancos.id')
            ->select('bancos.codigo')
            ->where('conta_bancarias.id','=',$configuracao_carteira->id_conta_bancaria)
            ->get();
        if(empty($codigo_banco)){
            return response()->error('Nenhum banco vinculado a conta bancária.');
        }

        $carteira = Carteira::find($configuracao_carteira->id_carteira);


        $beneficiario = new \Eduardokum\LaravelBoleto\Pessoa([
            'nome' => $condominio->first()->razao_social,
            'endereco' => $condominio->first()->endereco . ' N°' . $condominio->first()->numero. ', ' . $condominio->first()->complemento,
            'bairro' => $condominio->first()->bairro,
            'cep' => $condominio->first()->cep,
            'uf' => $condominio->first()->estado,
            'cidade' => $condominio->first()->cidade,
            'documento' => $condominio->first()->cnpj,
        ]);

        $conta_corrente = explode("-",$configuracao_carteira->conta_bancaria->conta,2);
        $conta_agencia = explode("-",$configuracao_carteira->conta_bancaria->agencia,2);

        $remessaArray = [];
        switch ($codigo_banco->first()->codigo){
            case 341:
                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $carteira->descricao);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);

                if ($configuracao_carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Itau($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Itau($remessaArray);
                }
                return $remessa;
                break;
            case 237:
                $configuracao_carteira = ConfiguracaoCarteira::find($configuracao_carteira->id);

                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $carteira->descricao);
                $remessaArray = array_add($remessaArray, 'idremessa', $configuracao_carteira->id_remessa);
                $remessaArray = array_add($remessaArray, 'codigoCliente', $configuracao_carteira->codigo_cedente);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);

                if ($configuracao_carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Bradesco($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Bradesco($remessaArray);
                }


                $configuracao_carteira->id_remessa = $configuracao_carteira->id_remessa +1;
                $configuracao_carteira->update();
                return $remessa;
                break;
            case 756:

                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $carteira->descricao);
                $remessaArray = array_add($remessaArray, 'idremessa', $configuracao_carteira->id_remessa);
                $remessaArray = array_add($remessaArray, 'convenio', $configuracao_carteira->codigo_cedente);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);

                if ($configuracao_carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Bancoob($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Bancoob($remessaArray);
                }

                $configuracao_carteira->id_remessa = $configuracao_carteira->id_remessa +1;
                $configuracao_carteira->update();
                return $remessa;
                break;
            default:
                return [];
                break;
        }
    }

    public function download_remessa($id_parcela, $dados =false){
        $condominio = Condominio::all()->first()->get();

        if(empty($condominio)){
            return response()->error('Necessário informar os dados do Cedente, verifique em Configurações->Condomínio.');
        }

        $parcela_boleto = ParcelaBoleto::find($id_parcela);

        $beneficiario = new \Eduardokum\LaravelBoleto\Pessoa([
            'nome' => $condominio->first()->razao_social,
            'endereco' => $condominio->first()->endereco . ' N°' . $condominio->first()->numero. ', ' . $condominio->first()->complemento,
            'bairro' => $condominio->first()->bairro,
            'cep' => $condominio->first()->cep,
            'uf' => $condominio->first()->estado,
            'cidade' => $condominio->first()->cidade,
            'documento' => $condominio->first()->cnpj,
        ]);

        $conta_corrente = explode("-",$parcela_boleto->parcela->recebimento->carteira->conta_bancaria->conta,2);
        $conta_agencia = explode("-",$parcela_boleto->parcela->recebimento->carteira->conta_bancaria->agencia,2);

        $remessaArray = [];
        switch ($parcela_boleto->parcela->recebimento->carteira->conta_bancaria->banco->codigo){
            case 341:
                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);

                if ($parcela_boleto->parcela->recebimento->carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Itau($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Itau($remessaArray);
                }

                break;
            case 237:

                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);
                $remessaArray = array_add($remessaArray, 'idremessa', $parcela_boleto->parcela->recebimento->carteira->id_remessa);
                $remessaArray = array_add($remessaArray, 'codigoCliente', $parcela_boleto->parcela->recebimento->carteira->codigo_cedente);

                if ($parcela_boleto->parcela->recebimento->carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Bradesco($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Bradesco($remessaArray);
                }

                $parcela_boleto->parcela->recebimento->carteira->update([
                    "id_remessa" => $parcela_boleto->parcela->recebimento->carteira->id_remessa +1]
                );
                break;
            case 756:
                $remessaArray = array_add($remessaArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $remessaArray = array_add($remessaArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $remessaArray = array_add($remessaArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $remessaArray = array_add($remessaArray, 'contaDv', $conta_corrente[1]);
                }
                $remessaArray = array_add($remessaArray, 'carteira', $parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                $remessaArray = array_add($remessaArray, 'beneficiario', $beneficiario);
                $remessaArray = array_add($remessaArray, 'idremessa', $parcela_boleto->parcela->recebimento->carteira->id_remessa);
                $remessaArray = array_add($remessaArray, 'convenio', $parcela_boleto->parcela->recebimento->carteira->codigo_cedente);

                if ($parcela_boleto->parcela->recebimento->carteira->layout_remessa->descricao === 'CNAB400'){
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab400\Banco\Bancoob($remessaArray);
                } else {
                    $remessa = new \Eduardokum\LaravelBoleto\Cnab\Remessa\Cnab240\Banco\Bancoob($remessaArray);
                }
                $parcela_boleto->parcela->recebimento->carteira->update([
                        "id_remessa" => $parcela_boleto->parcela->recebimento->carteira->id_remessa +1]
                );
                break;
            default:
                return [];
                break;
        }

        if($dados){
            return $remessa;
        }

        $boleto = $this->visualizar_boleto($id_parcela,'',true);

        $remessa->addBoleto($boleto);
        $content = $remessa->gerar();
        if($boleto->getCodigoBanco()==237) {
            $dsname = 'CB' . date( 'd', strtotime( $boleto->getDataDocumento())) . date( 'm', strtotime( $boleto->getDataDocumento())) . 'A'. strtoupper(str_random(1));
            $file_name = $dsname . '.rem';
        } elseif($boleto->getCodigoBanco()  == 756) {
            $content = mb_convert_encoding($content, 'Windows-1252');
            $file_name = strtoupper( str_random(7)) . '.rem';
        } else {
            $file_name = strtoupper(str_random(7)) . '.rem';
        }

        \Storage::disk('local')->put('remessas/' . $file_name, $content);

        $file_path = storage_path('app/remessas/' .$file_name);
        $parcela_boleto->file_remessa = $file_path;
        $parcela_boleto->update();

        $result =[
            "file_path" => $file_path,
            "file_name" => $file_name
            ];
        return $result;

    }

    public function visualizar_boleto($id_parcela, $tipo, $dados = false) {
        $condominio = Condominio::all()->first()->get();

        if(empty($condominio)){
            return response()->error('Necessário informar os dados do Cedente, verifique em Configurações->Condomínio.');
        }

        $parcela_boleto = ParcelaBoleto::find($id_parcela);

        $MULTA = $parcela_boleto->percentualmulta;
        $JUROS = $parcela_boleto->percentualjuros;
        $DATA_VENCIMENTO = DataHelper::setDate($parcela_boleto->data_vencimento);
        $receita = Receita::all('instrucaosacado','localdepagamento')->first()->get();

        $instrucao = [$receita->first()->instrucaosacado];
        $instrucao = str_replace('$MULTA',$MULTA . '%', $instrucao);
        $instrucao = str_replace('$JUROS',$JUROS . '%', $instrucao );
        $instrucao = str_replace('$DATA_VENCIMENTO',$DATA_VENCIMENTO , $instrucao);
        /***
         * Realiza o tratamento para que na instrução do boleto caber a quantidade de carateres exata.
         * A biblioteca de boletos recebe um array com 8 posição.
         * Tratado para o array de $instrucoes não passar o limite.
         *
        */
        if(strlen($instrucao[0])> 694){
            $instrucoes =  str_split( (substr($instrucao[0],0,690) . '...'), 87);
        } else {
            $instrucoes =  str_split( substr($instrucao[0],0,694), 87);
        }


        $beneficiario = new \Eduardokum\LaravelBoleto\Pessoa([
            'nome' => $condominio->first()->razao_social,
            'endereco' => $condominio->first()->endereco . ' N°' . $condominio->first()->numero. ', ' . $condominio->first()->complemento,
            'bairro' => $condominio->first()->bairro,
            'cep' => $condominio->first()->cep,
            'uf' => $condominio->first()->estado,
            'cidade' => $condominio->first()->cidade,
            'documento' => $condominio->first()->cnpj,
        ]);

        if($parcela_boleto->parcela->recebimento->empresa) {
            $pagador = new \Eduardokum\LaravelBoleto\Pessoa([
                'nome' => $parcela_boleto->parcela->recebimento->empresa->nome_fantasia,
                'endereco' => $parcela_boleto->parcela->recebimento->empresa->endereco,
                'bairro' => $parcela_boleto->parcela->recebimento->empresa->bairro,
                'cep' => $parcela_boleto->parcela->recebimento->empresa->cep,
                'uf' => $parcela_boleto->parcela->recebimento->empresa->estado,
                'cidade' =>$parcela_boleto->parcela->recebimento->empresa->cidade,
                'documento' => $parcela_boleto->parcela->recebimento->empresa->cnpj,
            ]);
        } else {
            $imovel_agregados = Imovel::join('imovel_agregado','imovel_agregado.id_imovel_principal', 'imovel.id')
                ->where('imovel_agregado.id_imovel_principal',$parcela_boleto->parcela->recebimento->imovel->id )
                ->where('imovel_agregado.softdeleted', 0)
                ->get();
            $quadra = $parcela_boleto->parcela->recebimento->imovel->quadra;
            $lote = $parcela_boleto->parcela->recebimento->imovel->lote;
            if (count($imovel_agregados)){
                foreach ($imovel_agregados as $imovel_agregado){
                    $lote = $lote . '/' . $imovel_agregado->lote;
                }
            }
            if ($parcela_boleto->parcela->recebimento->associado->morador->end_secundario_correspondencia =='s'){
                \Log::debug($parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario);
                $pagador = new \Eduardokum\LaravelBoleto\Pessoa([
                    'nome' => $parcela_boleto->parcela->recebimento->associado->nome,
                    'endereco' => $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->endereco . $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->complemento ?
                        $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->endereco . $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->complemento :
                        $parcela_boleto->parcela->recebimento->imovel->logradouro . ' N'. ($parcela_boleto->parcela->recebimento->imovel->numero ? $parcela_boleto->parcela->recebimento->imovel->numero : 'SN')
                        . ' QD ' . $quadra . 'LT ' . $lote ,
                    'bairro' => $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->bairro ?
                        $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->bairro : $condominio->first()->bairro,
                    'cep' => $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->cep ?
                        $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->cep : $parcela_boleto->parcela->recebimento->imovel->cep ,
                    'uf' => $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->uf ?
                        $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->uf :  $condominio->first()->estado,
                    'cidade' => $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->cidade ?
                        $parcela_boleto->parcela->recebimento->associado->morador->endereco_secundario->cidade : $condominio->first()->cidade ,
                    'documento' => $parcela_boleto->parcela->recebimento->associado->cpf,
                ]);
            } else {
                $pagador = new \Eduardokum\LaravelBoleto\Pessoa([
                    'nome' => $parcela_boleto->parcela->recebimento->associado->nome,
                    'endereco' => $parcela_boleto->parcela->recebimento->imovel->logradouro . ' N'. ($parcela_boleto->parcela->recebimento->imovel->numero ? $parcela_boleto->parcela->recebimento->imovel->numero : 'SN')
                        . ' QD ' . $quadra . 'LT ' . $lote ,
                    'bairro' => $condominio->first()->bairro,
                    'cep' => $parcela_boleto->parcela->recebimento->imovel->cep,
                    'uf' => $condominio->first()->estado,
                    'cidade' => $condominio->first()->cidade,
                    'documento' => $parcela_boleto->parcela->recebimento->associado->cpf,
                ]);
            }
        }

        $demonstrativo = [];
        $i = 0;
        $descricoes = "";
        $i=0;
        $x=0;
        foreach ($parcela_boleto->parcela->recebimento->lancamentos as $lancamento) {
            if(($i%2)==0 && $i != 0){
                if(count($demonstrativo)<4 || count($demonstrativo) == 4 ) {
                    $demonstrativo = array_add($demonstrativo, $x, $descricoes);
                    $x++;
                    $descricoes = "";
                    if ($lancamento->lancamento->categoria == 7) {
                        $descricoes = $lancamento->lancamento->descricao . ' -R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    } else {
                        $descricoes = $lancamento->lancamento->descricao . ' R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    }
                }
            } else {
                if(!$descricoes){
                    if ($lancamento->lancamento->categoria == 7) {
                        $descricoes = $lancamento->lancamento->descricao . ' -R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    } else {
                        $descricoes = $lancamento->lancamento->descricao . ' R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    }
                } else {
                    if ($lancamento->lancamento->categoria == 7) {
                        $descricoes = $descricoes . ' / ' . $lancamento->lancamento->descricao . ' -R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    } else {
                        $descricoes = $descricoes . ' / ' . $lancamento->lancamento->descricao . ' R$' . number_format($lancamento->lancamento->valor, 2, ',', '.');
                    }
                }
            }
            $i++;
        }
        if(!$demonstrativo){
            $demonstrativo = array_add($demonstrativo, $x, $descricoes);
        } else {
            if(count($demonstrativo)<4 || count($demonstrativo) == 4 ) {
                $demonstrativo = array_add($demonstrativo, $x, $descricoes);
            }
        }
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        $boletoArray = [
            'logo' =>  $path_logo ,// Logo da empresa
            'dataVencimento' => new \Carbon\Carbon(DataHelper::setDate($parcela_boleto->data_vencimento)),
            'valor' => $parcela_boleto->parcela->valor,
            'multa' => $parcela_boleto->percentualmulta, // porcento 10.00
            'juros' => $parcela_boleto->percentualjuros, // porcento ao mes 2.00
            'juros_apos' =>  $parcela_boleto->juros_apos, // juros e multa após 1
            'diasProtesto' => $parcela_boleto->dias_protesto, // protestar após, se for necessário
            'numero' => $parcela_boleto->nosso_numero,
            'numeroDocumento' => $parcela_boleto->numero_documento,
            'numeroControle'=> $parcela_boleto->numero_controler,
            'pagador' => $pagador, // Objeto PessoaContract
            'beneficiario' => $beneficiario, // Objeto PessoaContract
            'descricaoDemonstrativo' => $demonstrativo, // máximo de 5
            'instrucoes' =>  $instrucoes, //"Cobrar multa de $MULTA% e juros de $JUROS% ao mês. Não receber após o dia $DATA_VENCIMENTO" máximo de 5
            'aceite' => $parcela_boleto->aceite,
            'especieDoc' => $parcela_boleto->especie_doc,
            'local_pagamento' => $receita->first()->localdepagamento,
            'status'=> $parcela_boleto->status ? $parcela_boleto->status : 1
        ];

        $conta_corrente = explode("-",$parcela_boleto->parcela->recebimento->carteira->conta_bancaria->conta,2);
        $conta_agencia = explode("-",$parcela_boleto->parcela->recebimento->carteira->conta_bancaria->agencia,2);

        switch ($parcela_boleto->parcela->recebimento->carteira->conta_bancaria->banco->codigo) {
            case 341:
                //informar agencia
                $boletoArray = array_add($boletoArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $boletoArray = array_add($boletoArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $boletoArray = array_add($boletoArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $boletoArray = array_add($boletoArray, 'contaDv', $conta_corrente[1]);
                }
                $boletoArray = array_add($boletoArray,'carteira',$parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                //return $boletoArray;
                $boleto = new \Eduardokum\LaravelBoleto\Boleto\Banco\Itau($boletoArray);
//                return $boleto;
                break;
            case 237:
                //informar agencia
                $boletoArray = array_add($boletoArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $boletoArray = array_add($boletoArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $boletoArray = array_add($boletoArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $boletoArray = array_add($boletoArray, 'contaDv', $conta_corrente[1]);
                }
                $boletoArray = array_add($boletoArray,'carteira',$parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                $boletoArray = array_add($boletoArray,'codigoCliente',$parcela_boleto->parcela->recebimento->carteira->codigo_cedente);
                $boleto = new \Eduardokum\LaravelBoleto\Boleto\Banco\Bradesco($boletoArray);
//                return $boleto;
                break;
            case 756:
                //informar agencia
                $boletoArray = array_add($boletoArray,'agencia',$conta_agencia[0]);
                if(isset($conta_agencia[1])) {
                    $boletoArray = array_add($boletoArray,'agenciaDv',$conta_agencia[1]); // se possuir
                }
                $boletoArray = array_add($boletoArray,'conta', $conta_corrente[0]);
                if(isset($conta_corrente[1])) {
                    $boletoArray = array_add($boletoArray, 'contaDv', $conta_corrente[1]);
                }
                $boletoArray = array_add($boletoArray,'carteira',$parcela_boleto->parcela->recebimento->carteira->carteira->descricao);
                $boletoArray = array_add($boletoArray,'convenio',$parcela_boleto->parcela->recebimento->carteira->codigo_cedente);
                $boleto = new \Eduardokum\LaravelBoleto\Boleto\Banco\Bancoob($boletoArray);
//                return $boleto;
                break;
            default:
//                return [];
                $boleto = [];
                break;
        }

        if($parcela_boleto->status == 2) {
            $boleto->alterarBoleto();
        }elseif ($parcela_boleto->status == 3) {
            $boleto->baixarBoleto();
        }
        if ($dados) {
            return $boleto;
        }

        $competencia = new \Carbon\Carbon(DataHelper::setDate($parcela_boleto->data_vencimento_origem));
        $mes=  $competencia->month;
        $ano = $competencia->year;
        $faturaService = new FaturaService();
        $htmlFatura = $faturaService->htmlFatura($id_parcela, $mes, $ano);
        $pdf = new \Eduardokum\LaravelBoleto\Boleto\Render\Pdf();
        $pdf->addBoleto($boleto);
        $pdf->hideInstrucoes();
        $pdf->gerarBoleto(\Eduardokum\LaravelBoleto\Boleto\Render\Pdf::OUTPUT_SAVE, storage_path('app/boletos/meu_boleto.pdf'));
        $pdf_path = storage_path('app/boletos/meu_boleto.pdf');
        $mpdf = new PrintPdf('', '','','',5,5,5,5);
        $mpdf->SetImportUse();
        $pagecount = $mpdf->SetSourceFile($pdf_path);
        $mpdf->WriteHTML($htmlFatura);
        $mpdf->AddPage();
        $tplId = $mpdf->ImportPage($pagecount);
        $mpdf->UseTemplate($tplId);

        return response($mpdf->Output('Fatura_'.$mes.'_'.$ano.".pdf", $tipo), 200)->header('Content-Type', 'application/pdf');
    }

}