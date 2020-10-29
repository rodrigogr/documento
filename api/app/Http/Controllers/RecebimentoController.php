<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Helpers\DataHelper;
use App\Mail\BoletoMail;
use App\Models\ArquivoRetorno;
use App\Http\Requests\RecebimentoRequest;
use App\Models\Condominio;
use App\Models\ConfiguracaoCarteira;
use App\Models\ContaBancaria;
use App\Models\ContasReceber;
use App\Models\FluxoCaixa;
use App\Models\ImovelPermanente;
use App\Models\Lancamento;
use App\Models\LancamentoFundo;
use App\Models\LancamentosContaReceber;
use App\Models\LancamentoTaxa;
use App\Models\LayoutRemessa;
use App\Models\LayoutRetorno;
use App\Models\ParcelaBoleto;
use App\Models\PreLancamento;
use App\Models\Recebimento;
use App\Models\RecebimentoParcela;
use App\Models\Receita;
use App\Models\SendEmail;
use App\Models\TitulosProcessado;
use App\Services\BoletoServices;
use App\Services\FluxoCaixaServices;
use App\Services\FinanceServices;
use Carbon\Carbon;
use League\Flysystem\Exception;
use Respect\Validation\Validator;
use Illuminate\Http\Request;
use Symfony\Component\VarDumper\Cloner\Data;
use App\PrintPdf;
use App\Services\FaturaService;


class RecebimentoController extends Controller
{
    protected $finance_service;
    private $name = 'Recebimento';

    function __construct()
    {
        $this->finance_service = new FinanceServices();
    }

    public function index()
    {
        return response()->success(Recebimento::all());
    }

    public function show($id)
    {
        $Data = Recebimento::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Função utilizada para processar o arquivo de retonro e realizar baixa dos títulos.
     *- A leitura do arquivo é realizado pela biblioteca "EduardoKum/laravel-boleto", ela faz leitura do arquivo utlizando  layouts CNAB400 ou CNAB240.
     *- Depois de realizar o processamento pela biblioteca, ela retorna objeto com os dados do arquivo, header, detalhes e trailer.
     *- Com os dados do arquivo é realizado o processo de realizar a baixa.
     */
    public function processar_arquivo(RecebimentoRequest $request)
    {
        try {
            set_time_limit(0);
            $data = $request->all();

            /**
             * INICIO - PROCESSAMENTO
             * Realiza validação do arquivo, obtem o arquivo e processa ele utilizado a biblioteca "EduardoKum/laravel-boleto"
             */
            if (!$data['file']) {
                return response()->error("Arquivo não selecionado!");
            }
//            $file = str_replace('data:;base64,', '', $data['file']);
            $file = explode(",",$data["file"]);
            $file = base64_decode(end($file));

            $retorno = \Eduardokum\LaravelBoleto\Cnab\Retorno\Factory::make($file);
            $retorno->processar();

            /**
             * FIM - PROCESSAMENTO
             */

            /**
             *  Declarações e objeto com informações para ser utilizado no processo da biaxa.
             */
            $configuracao_receita = Receita::first();
            if(!count($configuracao_receita)) {
                return response()->error("Configuração receita invalida.");
            }
            $configuracao_carteira = ConfiguracaoCarteira::find($request->id_configuracao_carteira);
            if (!count($configuracao_carteira)) {
                return response()->error("Carteira não disponível.");
            }

            $layout_retorno = LayoutRetorno::find($request->id_layout);
            if (!count($layout_retorno)) {
                return response()->error("Layout não disponível.");
            }

            $qtd_processada = 0;
            $qtd_recebida = 0;
            $qtd_rejeitada = 0;
            $outras_operacoes = 0;
            $nosso_numero = null;

            /**
             * FIM - DECLARAÇÔES
             */


            \DB::beginTransaction();

            $arquivo_retorno = ArquivoRetorno::where('nome_arquivo', '=', $request->file_name)->get()->first();
            if (!count($arquivo_retorno)) {
                //return response()->error("Arquivo já processado");
                $file_path = \Storage::disk('local')->put('retornos/' . $request->file_name, $file);
                $arquivo_retorno = new ArquivoRetorno();
                $arquivo_retorno->nome_arquivo = $request->file_name;
                $arquivo_retorno->caminho_arquivo = $file_path;
                $arquivo_retorno->layout = $layout_retorno->descricao;
                $arquivo_retorno->data_leitura = Carbon::now();
                $arquivo_retorno->save();
            }


            foreach ($retorno as $registro) {
                $new_register = false;
                $titulo = false;
                $titulo_retorno = $registro->toArray();
                \Log::debug($titulo_retorno);

                switch ($retorno->getBancoNome()){
                    case 'Banco Cooperativo do Brasil S.A. - BANCOOB':
                        if($configuracao_carteira->layout_retorno->descricao === 'CNAB240') {
                            $nosso_numero = substr($titulo_retorno['nossoNumero'], 0, -1);
                        } else {
                            $nosso_numero = $titulo_retorno['nossoNumero'];
                        }
                        break;
                    case 'Banco Bradesco S.A.':
                        $nosso_numero = substr($titulo_retorno['nossoNumero'], 0, -1);
                        break;
                    case 'Itaú Unibanco S.A.':
                        $nosso_numero = substr($titulo_retorno['nossoNumero'], 0, -1);
                        if (!empty($titulo_retorno['valorTarifa']) && $titulo_retorno['valorTarifa'] > 0) {
                            if ($titulo_retorno['ocorrenciaTipo'] ==1) {
                                $titulo_retorno['valorRecebido'] = (((double)$titulo_retorno['valor'] + (double)$titulo_retorno['valorMora'] + (double)$titulo_retorno['valorMulta']) - ((double)$titulo_retorno['valorDesconto'] + (double)$titulo_retorno['valorAbatimento']));
                            } else {
                                $titulo_retorno['valorRecebido'] = 0;
                            }
                        }
                        break;
                    default:
                        return response()->error("Banco Inválido!");
                        break;
                }

                $titulos_encontrados = ParcelaBoleto::where('nosso_numero', '=', (integer) $nosso_numero)->get();

                /* Verificação de vários títulos com o mesmo nosso_numero e se o pagamento foi de um título cancelado,
                * nesse caso fica provisionado e o que estava provisionado fica cancelado
                */
                if (count($titulos_encontrados) == 1) {
                    $titulo = $titulos_encontrados[0];
                } elseif (count($titulos_encontrados) > 1) {
                    $titulo = ParcelaBoleto::where('nosso_numero',(integer) $nosso_numero)->where('numero_documento',$titulo_retorno["numeroDocumento"])->first();
                    if($titulo && $titulo->situacao == 'Cancelado') {
                        $titulo->situacao = 'Provisionado';
                        $titulo->save();
                        ParcelaBoleto::where('nosso_numero',(integer) $nosso_numero)->where('numero_documento','!=',$titulo_retorno["numeroDocumento"])->where('situacao','Provisionado')
                            ->update(['situacao' => 'Cancelado']);
                    }
                }

                /**
                 * INICIO - GRAVAÇÂO DO TITULO PROCESSADO
                 * Cria ou atualiza o objeto, com as informações de cada boleto no arquivo.
                 */

                $titulos_processado = TitulosProcessado::where('nosso_numero', '=',$nosso_numero)
                    ->where('id_arquivo_retorno','=',$arquivo_retorno->id)
                    ->where('ocorrencia',$titulo_retorno['ocorrencia'])
                    ->where('ocorrencia_tipo',$titulo_retorno['ocorrenciaTipo'])
                    ->get()->first();
                if(!count($titulos_processado)){
                    $new_register = true;
                    $titulos_processado = new TitulosProcessado();
                }
                $titulos_processado->nosso_numero = $nosso_numero;
                $titulos_processado->numero_documento = $titulo_retorno['numeroDocumento'];
                $titulos_processado->numero_controle = $titulo_retorno['numeroControle'];
                $titulos_processado->ocorrencia = $titulo_retorno['ocorrencia'];
                $titulos_processado->ocorrencia_tipo = $titulo_retorno['ocorrenciaTipo'];
                $titulos_processado->desc_ocorrencia = $titulo_retorno['ocorrenciaDescricao'] . ' - ' .  $titulo_retorno['error'];
                $titulos_processado->dt_vencimento = DataHelper::setDate($titulo_retorno['dataVencimento']);
                $titulos_processado->dt_credito = DataHelper::setDate($titulo_retorno['dataCredito']);
                $titulos_processado->valor = $titulo_retorno['valor'];
                $titulos_processado->valor_tarifa = (double)$titulo_retorno['valorTarifa'];
                $titulos_processado->valor_iof = (double)$titulo_retorno['valorIOF'];
                $titulos_processado->valor_abatimento = (double)$titulo_retorno['valorAbatimento'];
                $titulos_processado->valor_desconto = (double)$titulo_retorno['valorDesconto'];
                $titulos_processado->valor_recebido = (double)$titulo_retorno['valorRecebido'];
                $titulos_processado->valor_titulo_origem = $titulo_retorno['valor'];
                $titulos_processado->valor_mora = (double)$titulo_retorno['valorMora'];
                $titulos_processado->valor_multa = (double)$titulo_retorno['valorMulta'];
                $titulos_processado->error = $titulo_retorno['error'];
                $titulos_processado->id_arquivo_retorno = $arquivo_retorno->id;
                $titulos_processado->dt_ocorrencia = DataHelper::setDate($titulo_retorno["dataOcorrencia"]);

                /**
                 * FIM - GRAVAÇÂO DO TITULO PROCESSADO
                 */

                if ($titulo) {
                    switch ($titulo_retorno['ocorrenciaTipo']) {
                        case 3: //Entrada
                            $titulos_processado->status = "Registrado";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 9: // Erros
                            $titulos_processado->status = "Não Registrado";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 6: // Outros
                            $titulos_processado->status = "Outros";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 5: // Protestada
                            $titulos_processado->status = "Protestado";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 4: // Alteração
                            $titulos_processado->status = "Alterado";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 2: // BAIXADA
                            $titulos_processado->status = "Baixa pelo banco";
                            $outras_operacoes = $outras_operacoes + 1;
                            break;
                        case 1:
                            if (!empty($titulo_retorno['valorRecebido']) && $titulo_retorno['valorRecebido'] > 0) {
                                $titulos_processado->dt_pagamento = $titulo_retorno["dataOcorrencia"];
                                if ($titulo->situacao == "Compensado" && $new_register) {
                                    $titulos_processado->status = "Pago em Duplicidade";
                                    $qtd_rejeitada = $qtd_rejeitada + 1;
                                } elseif($titulos_processado->status == "Pago em Duplicidade") {
                                    $qtd_rejeitada = $qtd_rejeitada + 1;
                                }elseif($titulos_processado->status == "Aprovado") {
                                    $qtd_recebida = $qtd_recebida + 1;
                                }elseif($titulos_processado->status == "Aprovado Manual") {
                                    $qtd_recebida = $qtd_recebida + 1;
                                }
                                else {
                                    $data_vencimento = Carbon::parse(DataHelper::setDate($titulo->data_vencimento_origem));
                                    $data_pagamento = Carbon::parse(DataHelper::setDate($titulo_retorno["dataOcorrencia"]));
                                    // Verifica se o vencimento foi um dia ultil.
                                    $data_vencimento = $this->finance_service->verificaDiaUtil($data_vencimento);

                                    if(strtotime($data_pagamento) > strtotime($data_vencimento)) {
                                        $dias_atraso = $data_pagamento->diffInDays($data_vencimento);
                                        $valor_juros = $this->calcular_juros_bancario($titulo->percentualjuros,$dias_atraso,round($titulo->parcela->valor,2));
                                        $valor_multa = $this->calcular_multa_bancaria($titulo->percentualmulta,round($titulo->parcela->valor,2));
                                        $valor_calculado = round($titulo->parcela->valor_origem,2) + $valor_juros + $valor_multa;

                                        $titulos_processado->valor_juros_calculado = $valor_juros;
                                        $titulos_processado->valor_multa_calculado = $valor_multa;
                                        $titulos_processado->valor_total_calculado = $valor_calculado;
                                        $titulos_processado->valor_titulo_origem = round($titulo->parcela->valor,2);

                                        //Caso tenha desconto ou abatimento, diminui o valor calculado
                                        if($titulo_retorno['valorDesconto']>0) {
                                            $valor_calculado = $valor_calculado - (double)$titulo_retorno['valorDesconto'];
                                        }
                                        if($titulo_retorno['valorAbatimento']>0) {
                                            $valor_calculado = $valor_calculado - (double)$titulo_retorno['valorAbatimento'];
                                        }

                                        if($titulo_retorno['valorRecebido']> $valor_calculado){
                                            //Recebimento a maior
                                            $titulos_processado->status = "Recebimento a maior";
                                            $qtd_rejeitada = $qtd_rejeitada + 1;
                                        }
                                        elseif ($titulo_retorno['valorRecebido'] < $valor_calculado) {
                                            //Recebimento a menor
                                            $titulos_processado->status = "Recebimento a menor";
                                            $qtd_rejeitada = $qtd_rejeitada + 1;
                                        } else {

                                            $lanc_juros_id = false;
                                            $lanc_multa_id = false;
                                            $lanc_desconto_id = false;
                                            $lanc_abatimento_id = false;

                                            //verifica se já existe lançamentos do tipo juros e multa
                                            foreach ($titulo->parcela->recebimento->lancamentos() as $item){
                                                if($item->lancamento->categoria == 6){
                                                    $lanc_juros_id = $item->lancamento->id;
                                                }
                                                if($item->lancamento->categoria == 5){
                                                    $lanc_multa_id = $item->lancamento->id;
                                                }
                                                if($item->lancamento->categoria == 7){
                                                    $lanc_desconto_id = $item->lancamento->id;
                                                }
                                                if($item->lancamento->categoria == 10){
                                                    $lanc_abatimento_id = $item->lancamento->id;
                                                }
                                            }
                                            // Receber
                                            if($lanc_multa_id) {
                                                //faça update do lançamento de multa
                                                $up_lanc_multa = Lancamento::find($lanc_multa_id);
                                                $up_lanc_multa->valor = $valor_multa;
                                                $up_lanc_multa->save();
                                            } else {
                                                $lancamento_multa = Lancamento::create([
                                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                                                    'saldo_receber' => 0,
                                                    'descricao' => 'Multa',
                                                    'valor' => $valor_multa,
                                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                                                ]);
                                                $lancamento_receber = LancamentosContaReceber::create([
                                                    'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                    'id_lancamento' => $lancamento_multa->id
                                                ]);
                                                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                            }

                                            if ($lanc_juros_id) {
                                                $up_lanc_jur = Lancamento::find($lanc_juros_id);
                                                $up_lanc_jur->valor = $valor_juros;
                                                $up_lanc_jur->save();
                                            } else {
                                                $lancamento_juros = Lancamento::create([
                                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                                                    'saldo_receber' => 0,
                                                    'descricao' => 'Juros',
                                                    'valor' => $valor_juros,
                                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                                                ]);
                                                $lancamento_receber = LancamentosContaReceber::create([
                                                    'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                    'id_lancamento' => $lancamento_juros->id
                                                ]);
                                                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                            }
                                            if($titulo_retorno['valorDesconto']>0) {
                                                if ($lanc_desconto_id) {
                                                    $lanc_desconto_id = Lancamento::find($lanc_desconto_id);
                                                    $lanc_desconto_id->valor = (double)$titulo_retorno['valorDesconto'];
                                                    $lanc_desconto_id->save();
                                                } else {
                                                    $lancamento_desconto = Lancamento::create([
                                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                                        'saldo_receber' => 0,
                                                        'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                                        'valor' => (double)$titulo_retorno['valorDesconto'],
                                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                                                    ]);
                                                    $lancamento_receber = LancamentosContaReceber::create([
                                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                        'id_lancamento' => $lancamento_desconto->id
                                                    ]);
                                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                                }
                                            }
                                            if($titulo_retorno['valorAbatimento']>0) {
                                                if ($lanc_abatimento_id) {
                                                    $lanc_abatimento_id = Lancamento::find($lanc_abatimento_id);
                                                    $lanc_abatimento_id->valor = (double)$titulo_retorno['valorAbatimento'];
                                                    $lanc_abatimento_id->save();
                                                } else {
                                                    $lancamento_abatimento = Lancamento::create([
                                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentoabatimento,
                                                        'saldo_receber' => 0,
                                                        'descricao' => $configuracao_receita->tipoLancamentoAbatimento->descricao,
                                                        'valor' => (double)$titulo_retorno['valorAbatimento'],
                                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Abatimentos')
                                                    ]);
                                                    $lancamento_receber = LancamentosContaReceber::create([
                                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                        'id_lancamento' => $lancamento_abatimento->id
                                                    ]);
                                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                                }
                                            }
                                            $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->update([
                                                'valor_total'=>$valor_calculado,
                                                'total_recebido' => $titulo_retorno['valorRecebido'],
                                                'valor_juros' => (double)$valor_juros,
                                                'valor_multa' => (double)$valor_multa,
                                                'valor_desconto'=> (double)$titulo_retorno['valorDesconto'],
                                                'valor_abatimento' => (double)$titulo_retorno['valorAbatimento']
                                            ]);

                                            $titulo->parcela->update([
                                                'valor'=>$valor_calculado,
                                                'valor_recebido' => (double)$titulo_retorno['valorRecebido'],
                                                'valor_multa' => (double)$valor_multa,
                                                'valor_juros' => (double)$valor_juros,
                                                'valor_desconto'=> (double)$titulo_retorno['valorDesconto'],
                                                'valor_abatimento' => (double)$titulo_retorno['valorAbatimento'],
                                                'data_recebimento' => $titulo_retorno['dataOcorrencia'],
                                                'data_compensado' => $titulo_retorno['dataCredito']
                                            ]);

                                            $titulo->situacao = "Compensado";
                                            $titulo->status = 3;
                                            $titulo->update();
                                            $titulos_processado->status = "Aprovado";
                                            $titulos_processado->recebimento = true;
                                            $qtd_recebida = $qtd_recebida + 1;

                                            //Fluxo Caixa
                                            $fluxo = [
                                                'id_conta_bancaria' => $titulo->parcela->recebimento->carteira->conta_bancaria->id,
                                                'id_parcela' => $titulo["id_parcela"],
                                                'valor' => $titulo_retorno['valorRecebido'],
                                                'data_vencimento' => DataHelper::setDate($titulo_retorno['dataVencimento']),
                                                'data_pagamento' => DataHelper::setDate($titulo_retorno['dataOcorrencia']),
                                                'fluxo' => 'RECEITA',
                                                'tabela' => 'recebimento_parcela',
                                                'descricao' => 'Boleto '.$titulo->nosso_numero . ' - ' . 'Titulo recebido',
                                                'referente' => $titulo->parcela->recebimento->associado->nome
                                            ];
                                            if (FluxoCaixa::where('id_parcela',$titulo->id_parcela)->where('tabela','recebimento_parcela')->first()) {
                                                FluxoCaixaServices::updateFluxo($fluxo);
                                            } else {
                                                FluxoCaixaServices::createFluxo($fluxo);
                                            }
                                        }
                                    } else {

                                        $titulo->parcela->valor = round($titulo->parcela->valor, 2);
                                        //Caso tenha desconto ou abatimento, diminui no valor do titulo
                                        if($titulo_retorno['valorDesconto']>0) {
                                            $titulo->parcela->valor = $titulo->parcela->valor - (double)$titulo_retorno['valorDesconto'];
                                        }
                                        if($titulo_retorno['valorAbatimento']>0) {
                                            $titulo->parcela->valor = $titulo->parcela->valor - (double)$titulo_retorno['valorAbatimento'];
                                        }

                                        if($titulo_retorno['valorRecebido'] > $titulo->parcela->valor){
                                            //Recebimento a maior
                                            $titulos_processado->status = "Recebimento a maior";
                                            $qtd_rejeitada = $qtd_rejeitada + 1;
                                        } elseif ($titulo_retorno['valorRecebido'] < $titulo->parcela->valor) {
                                            //Recebimento a menor
                                            $titulos_processado->status = "Recebimento a menor";
                                            $qtd_rejeitada = $qtd_rejeitada + 1;
                                        } else {

                                            $lanc_desconto_id = false;
                                            $lanc_abatimento_id = false;

                                            //verifica se já existe lançamentos do tipo juros e multa
                                            foreach ($titulo->parcela->recebimento->lancamentos() as $item){
                                                if($item->lancamento->categoria == 7){
                                                    $lanc_desconto_id = $item->lancamento->id;
                                                }
                                                if($item->lancamento->categoria == 10){
                                                    $lanc_abatimento_id = $item->lancamento->id;
                                                }
                                            }

                                            if($titulo_retorno['valorDesconto']>0) {
                                                if ($lanc_desconto_id) {
                                                    $lanc_desconto_id = Lancamento::find($lanc_desconto_id);
                                                    $lanc_desconto_id->valor = (double)$titulo_retorno['valorDesconto'];
                                                    $lanc_desconto_id->save();
                                                } else {
                                                    $lancamento_desconto = Lancamento::create([
                                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                                        'saldo_receber' => 0,
                                                        'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                                        'valor' => (double)$titulo_retorno['valorDesconto'],
                                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                                                    ]);
                                                    $lancamento_receber = LancamentosContaReceber::create([
                                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                        'id_lancamento' => $lancamento_desconto->id
                                                    ]);
                                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                                }
                                            }

                                            if($titulo_retorno['valorAbatimento']>0) {
                                                if ($lanc_abatimento_id) {
                                                    $lanc_abatimento_id = Lancamento::find($lanc_abatimento_id);
                                                    $lanc_abatimento_id->valor = (double)$titulo_retorno['valorAbatimento'];
                                                    $lanc_abatimento_id->save();
                                                } else {
                                                    $lancamento_abatimento = Lancamento::create([
                                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentoabatimento,
                                                        'saldo_receber' => 0,
                                                        'descricao' => $configuracao_receita->tipoLancamentoAbatimento->descricao,
                                                        'valor' => (double)$titulo_retorno['valorAbatimento'],
                                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Abatimentos')
                                                    ]);
                                                    $lancamento_receber = LancamentosContaReceber::create([
                                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                                                        'id_lancamento' => $lancamento_abatimento->id
                                                    ]);
                                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                                }
                                            }

                                            $titulos_processado->valor_total_calculado = $titulo->parcela->valor;
                                            $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->update([
                                                'total_recebido' => $titulo_retorno['valorRecebido'],
                                                'valor_juros' => (double)$titulo_retorno['valorMora'],
                                                'valor_multa' => (double)$titulo_retorno['valorMulta'],
                                                'valor_desconto' => (double)$titulo_retorno['valorDesconto'],
                                                'valor_abatimento' => (double)$titulo_retorno['valorAbatimento']

                                            ]);
                                            $titulo->parcela->update([
                                                'valor_recebido' => (double)$titulo_retorno['valorRecebido'],
                                                'valor_multa' => (double)$titulo_retorno['valorMulta'],
                                                'valor_juros' => (double)$titulo_retorno['valorMora'],
                                                'valor_desconto' => (double)$titulo_retorno['valorDesconto'],
                                                'valor_abatimento' => (double)$titulo_retorno['valorAbatimento'],
                                                'data_recebimento' => $titulo_retorno['dataOcorrencia'],
                                                'data_compensado' => $titulo_retorno['dataCredito']
                                            ]);
                                            $titulo->situacao = "Compensado";
                                            $titulo->status = 3;
                                            $titulo->update();
                                            $titulos_processado->status = "Aprovado";
                                            $titulos_processado->recebimento = true;
                                            $qtd_recebida = $qtd_recebida + 1;

                                            //se existe um boleto em aberto que foi gerado 2ª via que tem o mesmo número de documento deste título, ele será cancelado, pois esse título foi compensado antes da 2ª via. Ver tarefa BF-300
                                            /*$titulo_seg_via = ParcelaBoleto::where('numero_documento',$titulo->numero_documento)
                                                ->where('situacao','Provisionado')
                                                ->update(['situacao' => 'Cancelado']);
                                            if ($titulo_seg_via) {
                                                \DB::statement('update recebimento_parcelas set observacao = concat(observacao,?) where id = ?', [' - Obs.: este boleto foi cancelado pelo pagamento da 2ª via de nosso_numero: '.$titulo->nosso_numero, $titulo->id_parcela]);
                                            }*/

                                            //Fluxo Caixa
                                            $fluxo = [
                                                'id_conta_bancaria' => $titulo->parcela->recebimento->carteira->conta_bancaria->id,
                                                'id_parcela' => $titulo["id_parcela"],
                                                'valor' => $titulo_retorno['valorRecebido'],
                                                'data_vencimento' =>  DataHelper::setDate($titulo_retorno['dataVencimento']),
                                                'data_pagamento' => DataHelper::setDate($titulo_retorno['dataOcorrencia']),
                                                'fluxo' => 'RECEITA',
                                                'tabela' => 'recebimento_parcela',
                                                'descricao' => 'Boleto '.$titulo->nosso_numero . ' - ' . 'Titulo recebido',
                                                'referente' => $titulo->parcela->recebimento->associado->nome,
                                            ];
                                            if (FluxoCaixa::where('id_parcela',$titulo->id_parcela)->where('tabela','recebimento_parcela')->first()) {
                                                FluxoCaixaServices::updateFluxo($fluxo);
                                            } else {
                                                FluxoCaixaServices::createFluxo($fluxo);
                                            }
                                        }
                                    }
                                }
                            } else {
                                $titulos_processado->status = "Indefinido";
                                $outras_operacoes = $outras_operacoes + 1;
                            }
                            break;

                    }

                } else {
                    $titulos_processado->status = "Não encontrado (no sistema)";
                    $outras_operacoes = $outras_operacoes + 1;
                }

                $titulos_processado->save();
                $qtd_processada++;
            }

            $arquivo_retorno->outras_operacoes = $outras_operacoes;
            $arquivo_retorno->qtd_rejeitada =  $qtd_rejeitada;
            $arquivo_retorno->qtd_recebida = $qtd_recebida;
            $arquivo_retorno->qtd_processado = $qtd_processada;
            $arquivo_retorno->update();
            \DB::commit();
            return response()->success("Arquivo processado com sucesso!");
        } catch (\Error $e){
            \DB::rollBack();
            return response()->error("Problemas ao processar arquivo!");
        }
    }

    private function calcular_juros_bancario ($percentual_juros, $dias_atraso, $valor)
    {
        $total_dias_mes = 30;
        $percent_juros_diario  = number_format((($percentual_juros/$total_dias_mes)/100),5);
        $juros =  ($valor * $percent_juros_diario) * $dias_atraso;
        return round($juros,2);
    }

    private function calcular_multa_bancaria ($percentual_multa, $valor)
    {
        $calc_multa_percent = ($percentual_multa/100);
        $multa = $valor * $calc_multa_percent;
        return round($multa,2);
    }

    public function consultar_arquivo(RecebimentoRequest $request)
    {
        $data = $request->all();
        if(isset($data['type']) && $data['type'] != 'nosso_numero' && isset($data['data_inicio']) && isset($data['data_fim'])&& !empty($data['data_inicio']) && !empty($data['data_fim'])){
            $data_ini = DataHelper::setDate($data['data_inicio']);
            $data_fim = DataHelper::setDate($data['data_fim']);
            if($data['type'] == 'dt_processamento'){
                $Data = ArquivoRetorno::whereBetween('data_leitura',[$data_ini, $data_fim])->orderBy('id','DESC');
            } elseif($data['type'] == 'dt_compensacao') {
                $Data = ArquivoRetorno::whereHas('titulos_processado' , function($q) use($data_ini,$data_fim){
                    $q->whereBetween('dt_credito',[$data_ini, $data_fim]);
                })->orderBy('id','DESC');
            }
        } elseif (isset($data['type']) && $data['type'] == 'nosso_numero') {
            $Data = ArquivoRetorno::whereHas('titulos_processado' , function($q) use($data){
                $q->where('nosso_numero',$data['numero']);
            })->orderBy('id','DESC');
        } else {
            $Data = ArquivoRetorno::orderBy('id','DESC');
        }
        $Data = $Data->paginate(13);
        return response($Data);
    }

    public function titulos_processados($id_arquivo_retorno)
    {
        return response()->success(TitulosProcessado::where('id_arquivo_retorno', '=', $id_arquivo_retorno)->get());
    }

    public function titulosProcessadosByStatus($status, $id_arquivo_retorno)
    {
        $Data = TitulosProcessado::where('id_arquivo_retorno',$id_arquivo_retorno)->where('status',$status)->get();
        return response()->success($Data);
    }

    public function demonstrativo_titulo($id)
    {
        $Data = TitulosProcessado::find($id);
        $boleto = ParcelaBoleto::where('nosso_numero','=',$Data->nosso_numero)->get();
        $Data = array_add($Data,'valor_boleto', $boleto);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error('Título não encontrado!');
        }
    }

    public function cancelar_processamento($id)
    {
        return response()->success('Processamento Cancelado');
    }

    public function cancelar_titulo()
    {
        return response()->success('Titulo Cancelado!');
    }

    public function receber_todos(RecebimentoRequest $request)
    {
        return response()->success('Títulos Recebidos');
    }

    public function recebimento_manual(RecebimentoRequest $recebimentoRequest)
    {
        $data = $recebimentoRequest->all();
        $result = ContasReceber::join('imovel','imovel.id','=','contas_receber.id_imovel');
        $result->select('contas_receber.id','imovel.quadra','imovel.lote','pessoa.nome', 'contas_receber.valor_total',
            'contas_receber.total_abatimento','contas_receber.total_recebido','contas_receber.total_provisionado',
            'contas_receber.saldo_receber','contas_receber.data_agendamento');
        if(isset($data['tipo']) && $data['tipo'] == 'nosso_numero' || isset($data['tipo']) && $data['tipo'] == 'nosso_numero_origem'){
            $result->join('lancamentos_contas_receber','contas_receber.id','=','lancamentos_contas_receber.id_conta_receber')
                ->join('recebimento_lancamentos','lancamentos_contas_receber.id','=','recebimento_lancamentos.id_lancamento_receber')
                ->join('recebimento_parcelas','recebimento_lancamentos.id_recebimento','=','recebimento_parcelas.id_recebimento')
                ->join('parcela_boletos','recebimento_parcelas.id','=','parcela_boletos.id_parcela');

                if($data['tipo'] == 'nosso_numero') {
                    $result->where('nosso_numero','=',$data['numero']);
                } else {
                    $result->orWhere('nosso_numero_origem','=',$data['numero']);
                }

               $result->groupBy('nosso_numero','contas_receber.id','imovel.quadra', 'imovel.lote', 'pessoa.nome', 'contas_receber.valor_total',
                'contas_receber.total_abatimento', 'contas_receber.total_recebido', 'contas_receber.total_provisionado', 'contas_receber.saldo_receber', 'contas_receber.data_agendamento');
        }else{
            $result->join('lancamentos_contas_receber','contas_receber.id','=','lancamentos_contas_receber.id_conta_receber')
                ->join('recebimento_lancamentos','lancamentos_contas_receber.id','=','recebimento_lancamentos.id_lancamento_receber');
            if(isset($data['quadra'])) $result->where('imovel.quadra', '=',$data['quadra']);
            if(isset($data['lote'])) $result->where('imovel.lote','=', $data['lote']);
            $result->whereMonth('contas_receber.data_agendamento', '=', $data['mes_competencia']);
            $result->whereYear('contas_receber.data_agendamento', '=', $data['ano_competencia']);
            $result->groupBy('contas_receber.id');
        }
        $result->join('recebimentos','recebimento_lancamentos.id_recebimento','recebimentos.id')
            ->join('pessoa','recebimentos.idassociado','=','pessoa.id');
        $result = $result->get();
        return response()->success($result);
    }

    public function debitos($id)
    {
        $result = LancamentosContaReceber::join('lancamentos','lancamentos_contas_receber.id_lancamento','=','lancamentos.id')
            ->join('tipo_lancamentos','lancamentos.idtipo_lancamento','=','tipo_lancamentos.id')
            ->select('lancamentos.descricao as descricao_lancamento','tipo_lancamentos.descricao as descircao_plano', 'lancamentos.saldo_receber', 'lancamentos.valor', 'lancamentos.categoria')
            ->where('lancamentos_contas_receber.id_conta_receber','=',$id)
            ->get();
        return response()->success($result);
    }

    public function saldo_receber($id)
    {
        $result = LancamentosContaReceber::join('lancamentos','lancamentos_contas_receber.id_lancamento','=','lancamentos.id')
            ->join('tipo_lancamentos','lancamentos.idtipo_lancamento','=','tipo_lancamentos.id')
            ->select('lancamentos.descricao as descricao_lancamento','tipo_lancamentos.descricao as descircao_plano', 'lancamentos.saldo_receber', 'lancamentos.valor')
            ->where('lancamentos_contas_receber.id_conta_receber','=',$id,'and')->where('lancamentos.saldo_receber','<>',0)
            ->get();
        return response()->success($result);
    }

    public function ordem_pagamentos($id)
    {
        $result = RecebimentoParcela::join('parcela_boletos','recebimento_parcelas.id','=','parcela_boletos.id_parcela')
            ->join('recebimento_lancamentos','recebimento_lancamentos.id_recebimento','=','recebimento_parcelas.id_recebimento')
            ->join('lancamentos_contas_receber','recebimento_lancamentos.id_lancamento_receber','=','lancamentos_contas_receber.id')
            ->distinct()
            ->select('parcela_boletos.situacao', 'parcela_boletos.data_vencimento','parcela_boletos.data_vencimento_origem',
                'parcela_boletos.nosso_numero', 'recebimento_parcelas.valor','recebimento_parcelas.valor_origem', 'recebimento_parcelas.id',
                'recebimento_parcelas.data_recebimento', 'recebimento_parcelas.data_compensado', 'recebimento_parcelas.observacao','parcela_boletos.nosso_numero_origem'
            )
            ->where('lancamentos_contas_receber.id_conta_receber', '=', $id)
            ->get();
        return response()->success($result);
    }

    public function provisionar(){
    }

    public function composicao_ordem_pagamento(){
    }

    public function creditos(){
    }

    public function visualizar_boleto($id_parcela)
    {
        $boleto_service = new BoletoServices();
        return $boleto_service->visualizar_boleto($id_parcela,'I');
    }

    public function atualizar_boleto(RecebimentoRequest $request)
    {
        $data = $request->all();
        try {
            \DB::beginTransaction();
            $configuracao_cateira = ConfiguracaoCarteira::find($data['id_configuracao_carteira']);
            if(!count($configuracao_cateira)) {
                return response()->error('Carteira não encontrada!');
            }
            $layout_remessa = LayoutRemessa::find($data['id_layout_remessa']);
            if(!count($layout_remessa)){
                return response()->error('Layout inexistente!');
            }

            $parcela_boleto = ParcelaBoleto::find($data['id_parcela']);
            if(!count($parcela_boleto)) {
                return response()->error('Parcela não encontrada!');
            }

            // Se tem correção então o valor do juros é obrigatorio
            if(!isset($data['juros']) && (boolean)$data['com_correcao']){
                return response()->error('Necessário calcular o valor de juros!');
            }
            // Se tem correção então o valor do multa é obrigatorio
            if(!isset($data['multa']) && (boolean)$data['com_correcao']){
                return response()->error('Necessário calcular o valor de multa!');
            }
            if((boolean)$data['com_correcao']){
                // ## Essa parcela será mudada para o status CANCELADO e será criada uma nova parcela, de acordo com a tarefa BF-300
                    $parcela_boleto->situacao = 'Cancelado';
                    $parcela_boleto->update();
                    $recebimento_parcela = $parcela_boleto->parcela->toArray();
                    $novo_receb_parc = RecebimentoParcela::create($recebimento_parcela);
                    $parcela_boleto->id_parcela = $novo_receb_parc->id;
                    $parcela_boleto->situacao = 'Provisionado';
                    ParcelaBoleto::create($parcela_boleto->toArray());
                    unset($parcela_boleto);
                    unset($recebimento_parcela);
                    $parcela_boleto = ParcelaBoleto::find($novo_receb_parc->id);
                    \DB::update("update recebimento_parcelas set observacao = if(observacao is null,'Obs.: este boleto foi cancelado pela criação da 2ª via',concat(observacao,?)) where id = ?", [' - Obs.: este boleto foi cancelado pela criação da 2ª via',$data['id_parcela']]);
                // ## Fim novas alterações

                $Data = Recebimento::where('id',$parcela_boleto->parcela->id_recebimento)
                    ->with(['lancamentos' => function($q){
                        $q->with('lancamento');
                    }])
                    ->first();
                $lanc_juros_id = false;
                $lanc_multa_id = false;
                $lanc_desconto_id = false;
                $lanc_abatimento_id = false;
                $lanc_juridico_id = false;
                $lanc_correcao_id = false;
                //verifica se já existe lançamentos do tipo juros, multa, desconto, abatimento, juridico, correcao
                foreach ($Data->lancamentos as $item){
                    if($item->lancamento->categoria == 6){
                        $lanc_juros_id = $item->lancamento->id;
                    }
                    if($item->lancamento->categoria == 5){
                        $lanc_multa_id = $item->lancamento->id;
                    }
                    if($item->lancamento->categoria == 7){
                        $lanc_desconto_id = $item->lancamento->id;
                    }
                    if($item->lancamento->categoria == 10){
                        $lanc_abatimento_id = $item->lancamento->id;
                    }
                    if($item->lancamento->categoria == 8){
                        $lanc_juridico_id = $item->lancamento->id;
                    }
                    if($item->lancamento->categoria == 9){
                        $lanc_correcao_id = $item->lancamento->id;
                    }
                }

                //dados para serem usados caso crie novos lançamento
                $dados_lanc["id_conta_receber"] = $Data->lancamentos[0]->id_conta_receber;
                $dados_lanc["id_recebimento"] = $parcela_boleto->parcela->id_recebimento;
                $configuracao_receita = Receita::first();

                if($data["juros"]) {
                    if ($lanc_juros_id) {
                        //faça update do lançamento de juros
                        $up_lanc_jur = Lancamento::find($lanc_juros_id);
                        $up_lanc_jur->valor = $data["juros"];
                        $up_lanc_jur->save();
                    } else {
                        //cria novo lançamento de juros
                        $lancamento_juros = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                            'saldo_receber' => 0,
                            'descricao' => 'Juros',
                            'valor' => $data["juros"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_juros->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if($data["multa"]) {
                    if ($lanc_multa_id) {
                        //faça update do lançamento de multa
                        $up_lanc_multa = Lancamento::find($lanc_multa_id);
                        $up_lanc_multa->valor = $data["multa"];
                        $up_lanc_multa->save();
                    } else {
                        //cria novo lançamento de multa
                        $lancamento_multa = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                            'saldo_receber' => 0,
                            'descricao' => 'Multa',
                            'valor' => $data["multa"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_multa->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if ($data["valor_abatimento"]) {
                    if ($lanc_abatimento_id) {
                        $up_lanc_abatimento = Lancamento::find($lanc_abatimento_id);
                        $up_lanc_abatimento->valor = $data["valor_abatimento"];
                        $up_lanc_abatimento->save();
                    } else {
                        $lancamento_abatimento = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentoabatimento,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoAbatimento->descricao,
                            'valor' => $data["valor_abatimento"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Abatimentos')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_abatimento->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if ($data["valor_desconto"]) {
                    if ($lanc_desconto_id) {
                        $up_lanc_desconto = Lancamento::find($lanc_desconto_id);
                        $up_lanc_desconto->valor = $data["valor_desconto"];
                        $up_lanc_desconto->save();
                    } else {
                        $lancamento_desconto = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                            'valor' => $data["valor_desconto"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_desconto->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if ($data["valor_juridico"]) {
                    if ($lanc_juridico_id) {
                        $up_lanc_juridico = Lancamento::find($lanc_juridico_id);
                        $up_lanc_juridico->valor = $data["valor_juridico"];
                        $up_lanc_juridico->save();
                    } else {
                        $lancamento_juridico = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuridico,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoJuridico->descricao,
                            'valor' => $data["valor_juridico"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Juridico')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_juridico->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if ($data["valor_correcao"]) {
                    if ($lanc_correcao_id) {
                        $up_lanc_correcao = Lancamento::find($lanc_correcao_id);
                        $up_lanc_correcao->valor = $data["valor_correcao"];
                        $up_lanc_correcao->save();
                    } else {
                        $lancamento_correcao = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocorrecao,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoCorrecao->descricao,
                            'valor' => $data["valor_correcao"],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Correcoes')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $dados_lanc["id_conta_receber"],
                            'id_lancamento' => $lancamento_correcao->id
                        ]);
                        $parcela_boleto->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                $parcela_boleto->parcela->valor = (double)($data["valor_total"]);
                $parcela_boleto->parcela->update([
                    'valor' => $parcela_boleto->parcela->valor
                ]);

                $parcela_boleto->data_vencimento = $data['data_vencimento'];

                $parcela_boleto->nosso_numero_origem = $parcela_boleto->nosso_numero;
                $parcela_boleto->nosso_numero = $configuracao_cateira->nosso_numero_inicio;
                $parcela_boleto->status = 1;
                $configuracao_cateira->nosso_numero_inicio = $configuracao_cateira->nosso_numero_inicio + 1;
                $configuracao_cateira->update();
                \Log::debug("BOLETO ALTERADO - Nosso Numero antigo:" . $parcela_boleto->nosso_numero_origem . " Nosso Numero Atual: " .  $parcela_boleto->nosso_numero);
                $conta_receber = ContasReceber::find($dados_lanc["id_conta_receber"]);
                $conta_receber->valor_total = $parcela_boleto->parcela->valor;
                $conta_receber->update();
            } else {
                $parcela_boleto->data_vencimento = $data['data_vencimento'];
                $parcela_boleto->status = 4;//STATUS_ALTERACAO_DATA
            }

            $recebimento = Recebimento::find($parcela_boleto->parcela->id_recebimento);
            $recebimento->id_configuracao_carteira = $configuracao_cateira->id;
            $recebimento->id_layout_remessa = $layout_remessa->id;
            $recebimento->update();
            $parcela_boleto->update();
            \DB::commit();

            if ($parcela_boleto->status == 4) {
                return response()->success('Título atualizado com sucesso!');
            } else {
                return response()->success("Título provisionado com sucesso! O novo título foi gerado sob o Nosso Número: $parcela_boleto->nosso_numero");
            }

        } catch (Exception $e){
            \DB::rollBack();
            return response()->error("Problemas ao processar arquivo!");
        }
    }

    public function receber_titulo(RecebimentoRequest $request)
    {
        $data = $request->all();
        $configuracao_receita = Receita::first();
        if(!count($configuracao_receita)) {
            return response()->error("Configuração receita invalida.");
        }
        $titulo = ParcelaBoleto::find($data['id_titulo']);

        if(count($titulo)) {
            try {
                \DB::beginTransaction();
                //Verifica se já foi recebido mais de uma vez
                if (($data["received"])) {
                    //Verifica se o usuário concordou em duplicar ou cancelar
                    if ($data["i_agree"] == "duplicar") {
                        $data['valor_pago'] = $titulo->parcela->valor_recebido + $data['valor_pago'];
                        $data['valor_juros'] = $titulo->parcela->valor_juros + $data['valor_juros'];
                        $data['valor_multa'] = $titulo->parcela->valor_multa + $data['valor_multa'];
                        $data['valor_receber'] = $titulo->parcela->valor + $data['valor_receber'];
                    }
                    //no caso cancelar o recebimento ele vai substituir os valores conforme está na tela
                }

                $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->update([
                    'total_recebido' => $data['valor_pago'],
                    'valor_juros' => (double)$data['valor_juros'],
                    'valor_multa' => (double)$data['valor_multa'],
                    'valor_total' => (double)$data['valor_receber']
                ]);

                if (!empty($data['valor_multa']) && $data['valor_multa'] > 0) {
                    $lanc_multa_id = false;
                    //verifica se já existe lançamentos do tipo juros e multa
                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 5) {
                            $lanc_multa_id = $item->lancamento->id;
                        }
                    }
                    if ($lanc_multa_id) {
                        //faça update do lançamento de multa
                        $up_lanc_multa = Lancamento::find($lanc_multa_id);
                        $up_lanc_multa->valor = $data['valor_multa'];
                        $up_lanc_multa->save();
                    } else {
                        $lancamento_multa = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                            'saldo_receber' => 0,
                            'descricao' => 'Multa',
                            'valor' => $data['valor_multa'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_multa->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if (!empty($data['valor_juros']) && $data['valor_juros'] > 0) {
                    $lanc_juros_id = false;
                    //verifica se já existe lançamentos do tipo juros e multa
                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 6) {
                            $lanc_juros_id = $item->lancamento->id;
                        }
                    }
                    if ($lanc_juros_id) {
                        //faça update do lançamento de juros
                        $up_lanc_juros = Lancamento::find($lanc_juros_id);
                        $up_lanc_juros->valor = $data['valor_juros'];
                        $up_lanc_juros->save();
                    } else {
                        $lancamento_juros = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                            'saldo_receber' => 0,
                            'descricao' => 'Juros',
                            'valor' => $data['valor_juros'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_juros->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if (!empty($data['valor_juridico']) && $data['valor_juridico'] > 0) {
                    $lanc_juridico_id = false;

                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 8) {
                            $lanc_juridico_id = $item->lancamento->id;
                        }
                    }
                    if ($lanc_juridico_id) {
                        $up_lanc_juridico = Lancamento::find($lanc_juridico_id);
                        $up_lanc_juridico->valor = $data['valor_juridico'];
                        $up_lanc_juridico->save();
                    } else {
                        $lancamento_juridico = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuridico,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoJuridico->descricao,
                            'valor' => $data['valor_juridico'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Juridico')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_juridico->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if (!empty($data['valor_correcao']) && $data['valor_correcao'] > 0) {
                    $lanc_correcao_id = false;
                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 9) {
                            $lanc_correcao_id = $item->lancamento->id;
                        }
                    }

                    if ($lanc_correcao_id) {
                        $up_lanc_correcao = Lancamento::find($lanc_correcao_id);
                        $up_lanc_correcao->valor = $data['valor_correcao'];
                        $up_lanc_correcao->save();
                    } else {
                        $lancamento_correcao = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocorrecao,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoCorrecao->descricao,
                            'valor' => $data['valor_correcao'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Correcoes')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_correcao->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if (!empty($data['valor_desconto']) && $data['valor_desconto'] > 0) {
                    $lanc_desconto_id = false;
                    //verifica se já existe lançamentos do tipo desconto
                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 7) {
                            $lanc_desconto_id = $item->lancamento->id;
                        }
                    }
                    if ($lanc_desconto_id) {
                        //faça update do lançamento de juros
                        $up_lanc_desconto = Lancamento::find($lanc_desconto_id);
                        $up_lanc_desconto->valor = $data['valor_desconto'];
                        $up_lanc_desconto->save();
                    } else {
                        $lancamento_desconto = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                            'valor' => $data['valor_desconto'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_desconto->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }

                if (!empty($data['valor_abatimento']) && $data['valor_abatimento'] > 0) {
                    $lanc_abatimento_id = false;
                    foreach ($titulo->parcela->recebimento->lancamentos as $item) {
                        if ($item->lancamento->categoria == 10) {
                            $lanc_abatimento_id = $item->lancamento->id;
                        }
                    }

                    if ($lanc_abatimento_id) {
                        $up_lanc_abatimento = Lancamento::find($lanc_abatimento_id);
                        $up_lanc_abatimento->valor = $data['valor_abatimento'];
                        $up_lanc_abatimento->save();
                    } else {
                        $lancamento_abatimento = Lancamento::create([
                            'idtipo_lancamento' => $configuracao_receita->id_tipolancamentoabatimento,
                            'saldo_receber' => 0,
                            'descricao' => $configuracao_receita->tipoLancamentoAbatimento->descricao,
                            'valor' => $data['valor_abatimento'],
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Abatimentos')
                        ]);
                        $lancamento_receber = LancamentosContaReceber::create([
                            'id_conta_receber' => $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                            'id_lancamento' => $lancamento_abatimento->id
                        ]);
                        $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                    }
                }
                $recebido_anterior = $titulo->parcela->valor_recebido;
                $titulo->parcela->update([
                    'valor_recebido' => (double)$data['valor_pago'],
                    'valor_multa' => (double)$data['valor_multa'],
                    'valor_juros' => (double)$data['valor_juros'],
                    'data_recebimento' => $data['data_pagamento'],
                    'data_compensado' => $data['data_compensacao'],
                    'observacao' => $data['observacao'],
                    'valor' => (double)$data['valor_receber']
                ]);
                $titulo->status = 3;
                $titulo->situacao = "Compensado";
                $titulo->update();

                $fluxo_atualiza_descricao = ' Título recebido manual';
                $id_conta_bancaria = $titulo->parcela->recebimento->carteira->conta_bancaria->id;

                if (($data["received"])) {
                    if ($data["i_agree"] === "duplicar") {
                        $fluxo_atualiza_descricao = 'Recebimento manual título em duplicidade';
                    } else {
                        //Altualiza saldo
                        ContaBancaria::where('id', $id_conta_bancaria)->decrement('saldo', $recebido_anterior);
                        $fluxo_atualiza_descricao = 'Recebimento manual título atualizado';
                    }
                }
                //Titulos processados
                $titulo_processados = TitulosProcessado::whereRaw("trim(leading 0 from nosso_numero) = '".$titulo->nosso_numero."'")->first();
                if (count($titulo_processados)) {
                    $titulo_processados->status = 'Aprovado Manual';
                    $titulo_processados->recebimento = true;
                    $titulo_processados->save();
                }
                //Fluxo Caixa
                $fluxo = [
                    'id_parcela' => $data["id_titulo"],
                    'id_conta_bancaria' => $id_conta_bancaria,
                    'tabela' => 'recebimento_parcela',
                    'fluxo' => 'RECEITA',
                    'descricao' => 'Boleto '.$titulo->nosso_numero . ' - ' . $fluxo_atualiza_descricao,
                    'referente' => $titulo->parcela->recebimento->associado->nome,
                    'data_pagamento' => DataHelper::setDate($data['data_pagamento']),
                    'data_vencimento' => DataHelper::setDate($titulo->data_vencimento),
                    'valor' => $data["valor_pago"]
                ];
                if (FluxoCaixa::where('id_parcela',$titulo->id_parcela)->where('tabela','recebimento_parcela')->first()) {
                    FluxoCaixaServices::updateFluxo($fluxo);
                } else {
                    FluxoCaixaServices::createFluxo($fluxo);
                }

                \DB::commit();
                return response()->success("Título recebido!");

            } catch (Exception $e){
                \DB::rollBack();
                return response()->error($e->getMessage());
            }
        } else {
            return response()->error("Título inválido!");
        }
    }

    public function programarPreLancamento(Request $request)
    {
        try{
            $configuracao_receita = Receita::first();
            if(!count($configuracao_receita)) {
                return response()->error("Configuração receita invalida.");
            }
            $data = $request->all();
            $diferenca_valor = $data['valor'];
            if (!isset($data['id_titulo'])) {
                if (strlen($data['nosso_numero']) > 11) {
                    $data['nosso_numero'] = substr($data['nosso_numero'], 0, -1);
                }
                $titulo = ParcelaBoleto::where('nosso_numero', '=', (integer) $data['nosso_numero'])->first();
                if(!count($titulo)){
                    $titulo = ParcelaBoleto::where('numero_documento',(integer)$data['numero_documento'])->first();
                }
            } else {
                $titulo = ParcelaBoleto::find($data['id_titulo']);
            }
            if(!count($titulo)) {
                return response()->error("Título inválido!");
            }
            $descricao = '';
            $categoria = 0;
            $observacao = '';
            \DB::beginTransaction();
            if($data['desconto']){
                $descricao = 'Diferença do recebimento a maior';
                $categoria = EnumCategoriaLancamento::toOrdinal('Descontos');
                $observacao = '/*** Diferença do recebimento a maior realizado. **/';
            } else {
                $descricao = 'Diferença do recebimento a menor';
                $categoria = EnumCategoriaLancamento::toOrdinal('Outros');
                $observacao = '/*** Diferença do recebimento a menor realizado. **/';
            }
            //Criar um novo lançamento com o valor restante
            $lancamento = Lancamento::create([
                "valor" => $diferenca_valor,
                "saldo_receber" => $diferenca_valor,
                "idtipo_lancamento" => $configuracao_receita->id_tipolancamentocorrecao,
                "descricao" => $descricao,
                'categoria' => $categoria
            ]);

            $Data = PreLancamento::create([
                'id_lancamento' => $lancamento->id,
                'idimovel' => $titulo->parcela->recebimento->idimovel,
                'observacao' => $observacao,
                'mes' => (int)$data['mes'],
                'ano' => (int)$data['ano']
            ]);
            \DB::commit();
            return response()->success("Lançamento Cadastrado!");
        } catch(Exception $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());
            return response()->error("Problemas ao programar o lançamento!");
        }

    }

    public function baixar_titulo(RecebimentoRequest $request)
    {
        $data = $request->all();
        $configuracao_receita = Receita::first();
        if(!count($configuracao_receita)) {
            return response()->error("Configuração receita invalida.");
        }
        if(!$configuracao_receita->id_tipolancamentoabatimento) {
            return response()->error("Abatimento - Plano de lançamento não definido.");
        }
        if (!$configuracao_receita->id_tipolancamentojuridico) {
            return response()->error("Juridico - Plano de lançamento não definido.");
        }
        if (strlen((integer)$data['nosso_numero'])>7) {
            $data['nosso_numero'] = substr((integer)$data['nosso_numero'], 0, -1);
        }
        $titulo = ParcelaBoleto::where('nosso_numero',(integer)$data['nosso_numero'])->first();
        if(!count($titulo)){
            $titulo = ParcelaBoleto::where('numero_documento',(integer)$data['numero_documento'])->first();
        }
        if(count($titulo)) {
            $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->update([
                'total_recebido' => $data['valor_pago'],
                'valor_juros' => (double)$data['valor_juros_calculado'],
                'valor_multa' => (double)$data['valor_multa_calculado'],
                'valor_total'=> (double)$data['valor_receber']
            ]);

            if (!empty($data['valor_multa_calculado']) && $data['valor_multa_calculado'] > 0) {
                $lancamento_multa = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                    'saldo_receber' => 0,
                    'descricao' => 'Multa',
                    'valor' => $data['valor_multa_calculado'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Multa')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_multa->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }
            if (!empty($data['valor_juros_calculado']) && $data['valor_juros_calculado'] > 0) {
                $lancamento_juros = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                    'saldo_receber' => 0,
                    'descricao' => 'Juros',
                    'valor' => $data['valor_juros_calculado'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Juros')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_juros->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }

            if (!empty($data['valor_desconto']) && $data['valor_desconto'] > 0) {
                $lancamento_desconto = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                    'saldo_receber' => 0,
                    'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                    'valor' => $data['valor_desconto'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Descontos')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_desconto->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }
            if (!empty($data['valor_abatimento']) && $data['valor_abatimento'] > 0) {
                $lancamento_abatimento = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentoabatimento,
                    'saldo_receber' => 0,
                    'descricao' => $configuracao_receita->tipoLancamentoAbatimento->descricao,
                    'valor' => $data['valor_abatimento'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Descontos')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_abatimento->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }
            if (!empty($data['valor_juridico']) && $data['valor_juridico'] > 0) {
                $lancamento_juridico = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuridico,
                    'saldo_receber' => 0,
                    'descricao' => $configuracao_receita->tipoLancamentoJuridico->descricao,
                    'valor' => $data['valor_juridico'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Juridico')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_juridico->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }
            if (!empty($data['valor_correcao']) && $data['valor_correcao'] > 0) {
                $lancamento_correcao = Lancamento::create([
                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocorrecao,
                    'saldo_receber' => 0,
                    'descricao' => $configuracao_receita->tipoLancamentoCorrecao->descricao,
                    'valor' => $data['valor_correcao'],
                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Correcoes')
                ]);
                $lancamento_receber = LancamentosContaReceber::create([
                    'id_conta_receber'=> $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->id,
                    'id_lancamento' => $lancamento_correcao->id
                ]);
                $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
            }

            $titulo->parcela->update([
                'valor_recebido' => (double)$data['valor_pago'],
                'valor_multa' => (double)$data['valor_multa_calculado'],
                'valor_juros' => (double)$data['valor_juros_calculado'],
                'data_recebimento' => $data['data_pagamento'],
                'data_compensado' => $data['data_compensacao'],
                'valor'=>(double)$data['valor_receber']
            ]);
            $titulo->situacao = "Compensado";
            $titulo->update();

            $titulo_processado = TitulosProcessado::where('nosso_numero', $data['nosso_numero'])->where('id',$data['id_titulo_processado'])->first();
            if(count($titulo_processado)) {
                $titulo_processado->status = 'Aprovado Manual';
                $titulo_processado->update();
            }

            return response()->success("Título recebido!");
        } else {
            return response()->error("Título inválido!");
        }
    }

    public function download_remessa($id)
    {
        try {
            $boleto_service = new BoletoServices();
            $remessa = $boleto_service->download_remessa($id);
            $headers = array('Content-Type' => 'text/plan', 'Content-Disposition' => 'attachment"');
            return response()->download($remessa["file_path"], $remessa["file_name"], $headers);
        }  catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error('Problemas ao fazer o download da remessa! ' . $e->getMessage());
        }
    }

    public function enviar_email($id)
    {
        set_time_limit(0);
        $condominio = Condominio::first();
        $parcela_boleto = ParcelaBoleto::find($id);
        $lancamentos = [];
        $i=0;
        foreach ($parcela_boleto->parcela->recebimento->lancamentos as $lancamento) {
            $lancamentos[$i] = ['descricao'=>$lancamento->descricao, 'valor'=>DataHelper::getDoubleToReal($lancamento->valor)];
            $i++;
        }
        $emails = explode(";", $parcela_boleto->parcela->recebimento->associado->morador->email_alternativo);
        $infor_email = [
            'lancamentos'=>[
                $lancamentos
            ],
            'titulo'=>'Segunda via do Boleto',
            'vencimento'=>$parcela_boleto->data_vencimento,
            'associado'=>$parcela_boleto->parcela->recebimento->associado->nome,
            'nome_condominio'=> $condominio->nome_fantasia,
            'email_condominio'=> $condominio->email,
            'total'=>DataHelper::getDoubleToReal($parcela_boleto->parcela->valor)
        ];

        $boleto_service = new BoletoServices();
        $boleto_pdf = $boleto_service->visualizar_boleto($id,'S');

        $sent = null;

        if (\App::environment('production')) {
            foreach ($emails as $email) {
                if ($email) {
                    if (Validator::email()->validate($email)) {
                        $sent = \Mail::to($email)->send(new BoletoMail($infor_email, $boleto_pdf));
                        if ($sent) {
                            SendEmail::create([
                                'id_pessoa' => $parcela_boleto->parcela->recebimento->associado->morador->id_pessoa,
                                'email_enviado' => $email,
                                'menssagem' => 'Segunda via do Boleto',
                                'status' => 'Não Enviado'
                            ]);
                        } else {
                            SendEmail::create([
                                'id_pessoa' => $parcela_boleto->parcela->recebimento->associado->morador->id_pessoa,
                                'email_enviado' => $email,
                                'menssagem' => 'Segunda via do Boleto',
                                'status' => 'Enviado'
                            ]);
                        }
                    } else {
                        SendEmail::create([
                            'id_pessoa' => $parcela_boleto->parcela->recebimento->associado->morador->id_pessoa,
                            'email_enviado' => $email,
                            'menssagem' => 'Email Inválido',
                            'status' => 'Não Enviado'
                        ]);
                    }
                } else {
                    SendEmail::create([
                        'id_pessoa' => $parcela_boleto->parcela->recebimento->associado->morador->id_pessoa,
                        'email_enviado' => $email,
                        'menssagem' => 'Email Inválido',
                        'status' => 'Não Enviado'
                    ]);
                }
            }
        }  else {
            $sent = \Mail::to('desenvolvimento@uzer.com.br')->send(new BoletoMail($infor_email, $boleto_pdf, ''));
            if ($sent) {
                SendEmail::create([
                    'id_pessoa' => 1,
                    'email_enviado' => 'desenvolvimento@uzer.com.br',
                    'status' => 'Não Enviado'
                ]);
            } else {
                SendEmail::create([
                    'id_pessoa' => 1,
                    'email_enviado' => 'desenvolvimento@uzer.com.br',
                    'status' => 'Enviado'
                ]);
            }
        }
        set_time_limit(30);
        return response()->success("Email enviado!");
    }

    public function resultJurosMulta (Request $dados_boleto)
    {
        $data = $dados_boleto->all();

        $result = [];
        $juros = 0;
        $multa = 0;
        $data_vencimento_origem = Carbon::parse($data["dados"]["vencimento_origem"]);
        $data_correcao = Carbon::parse($data["dados"]["vencimento_correcao"]);
        if (!($data_correcao->timestamp <= $data_vencimento_origem->timestamp)) {
            $config_receita = Receita::first();
            $config_boleto = ParcelaBoleto::where('id_parcela', $data["dados"]["id_boleto"])->select('percentualmulta', 'percentualjuros')->first();
            $config_juros = $config_boleto->percentualjuros;
            $config_multa = $config_boleto->percentualmulta;
            $total_dias_mes = 30;
            //$calc_percent_juros = (($config_juros/$total_dias_mes)/100);
            $calc_percent_juros = number_format((($config_juros / $total_dias_mes) / 100), 5);

            $boleto = RecebimentoParcela::where('id', '=', $data["dados"]["id_boleto"])->first();

            $dias_atraso = $data_correcao->diffInDays($data_vencimento_origem);

            if ($dias_atraso > 0) {
                $valor = $boleto->valor_origem;
                if ($config_receita->modalidadejuro == 'Juros Simples') {
                    $juros = ($valor * $calc_percent_juros) * $dias_atraso;
                } else { //juros compostos
                    $M = $valor * pow((1 + $calc_percent_juros), $dias_atraso);
                    $juros = $M - $valor;
                }

                $calc_multa_percent = ($config_multa / 100);
                $multa = $boleto->valor_origem * $calc_multa_percent;
            }
        }
        $result["juros"] = round($juros,2);
        $result["multa"] = round($multa,2);
        return response($result);
    }

    public function update_categoria()
    {
        $result_taxa = Lancamento::where('created_at','<','2017-06-06 08:01:40')->get();

        foreach ($result_taxa as $item){
            switch ($item->idtipo_lancamento){
                case 1:
                    $item->update(array("categoria"=> EnumCategoriaLancamento::toOrdinal('Taxa')));
                    break;
                case 2:
                    $item->update(array("categoria"=> EnumCategoriaLancamento::toOrdinal('Fundo')));
                    break;
                default:
                    $item->update(array("categoria"=> EnumCategoriaLancamento::toOrdinal('Outros')));
                    break;
            }
        }

        return "Atualizado!";
    }

    public function update_valor_origem()
    {
        $parcelas = RecebimentoParcela::where('valor_origem','=',0)->get();
        foreach ($parcelas as $parcela){
            //$parcela->update(array('valor_origem'=> $parcela->recebimento->lancamentos->first()->conta_receber->valor_total));
            $parcela->valor_origem = $parcela->recebimento->lancamentos->first()->conta_receber->valor_total;
            $parcela->update();
        }
        return "Concluido!";
    }

    public function update_data_vencimento_origem()
    {
        $parcela_boletos = ParcelaBoleto::whereNull('data_vencimento_origem')->get();
        foreach ($parcela_boletos as $parcela_boleto){
            $parcela_boleto->data_vencimento_origem= $parcela_boleto->parcela->recebimento->lancamentos->first()->conta_receber->data_agendamento;
            $parcela_boleto->update();
        }
        return "Concluido!";
    }

    public function gerarBoletoMensal()
    {
        $valor_total = 0;
        $lancamentos = array();
        \DB::beginTransaction();
        $carteira = ConfiguracaoCarteira::find(1);
        $associado = ImovelPermanente::getTitularImovel(391);
        $lancamento_taxa = Lancamento::create([
            'idtipo_lancamento' => 1,
            'descricao' => 'Taxa de Manutenção m2',
            'valor' => 618.47076497539,
            'saldo_receber' => 0,
            'categoria' =>EnumCategoriaLancamento::toOrdinal('Taxa')
        ]);
        $lancamentos = array_add($lancamentos, 'id_lancamento_taxa', $lancamento_taxa->id);
        $valor_total = (double)$lancamento_taxa->valor;


        //Registra a taxa calculada
        $taxa = LancamentoTaxa::create([
            'id_receita_calculos' => 2,
            'id_lancamento' => $lancamento_taxa->id,
            'id_imovel' => 391
        ]);

        $lancamento_fundo = Lancamento::create([
            'idtipo_lancamento' => 2,
            'saldo_receber' => 0,
            'descricao' => 'Fundo de Reserva',
            'valor' => 61.85,
            'categoria' =>EnumCategoriaLancamento::toOrdinal('Fundo')
        ]);
        $lancamentos = array_add($lancamentos, 'id_lancamento_fundo', $lancamento_fundo->id);
        $valor_total = $valor_total + (double)$lancamento_fundo->valor;


        //Registra o fundo de reserva calculado
        $fundo = LancamentoFundo::create([
            'id_receita_calculos' => 2,
            'id_lancamento' => $lancamento_fundo->id,
            'id_imovel' => 391
        ]);

        //Registra uma conta receber
        $conta_receber = new ContasReceber();
        $conta_receber->valor_total = $valor_total;
        $conta_receber->valor_original = $valor_total;
        $conta_receber->total_provisionado = $valor_total;
        $conta_receber->data_agendamento = '10/08/2017';
        $conta_receber->id_imovel = 391;
        $conta_receber->save();


        foreach ($lancamentos as $x => $value) {
            $conta_receber->lancamentos()->attach($value);
        }


        $recebimento = Recebimento::create([
            'id_configuracao_carteira' => 1,
            'id_layout_remessa' => 1,
            'idimovel' => 391,
            'idassociado' => $associado->first()->id_pessoa,
            'data_agendamento' => '10/08/2017',
            'numero_parcelas' => 1
        ]);

        foreach ($conta_receber->lancamentos as $lancamento) {
            $recebimento->lancamentos()->attach($lancamento->pivot->id);
        }

        $recebimento_parcela = RecebimentoParcela::create([
            'valor' => $conta_receber->valor_total,
            'valor_origem'=> $conta_receber->valor_total,
            'id_recebimento' => $recebimento->id,
            'forma_pagamento' => 'TITULO',
            'id_situacao_inadimplencia'=> 1

        ]);

        $titulo = ParcelaBoleto::create([
            'id_parcela' => $recebimento_parcela->id,
            'data_vencimento' => '10/08/2017',
            'data_vencimento_origem' =>'10/08/2017',
            'percentualmulta' => 2,
            'percentualjuros' => 1,
            'juros_apos' => 1,
            'dias_protesto' => false,
            'nosso_numero' => $carteira->nosso_numero_inicio,
            'numero_documento' =>  $recebimento->id,
            'numero_controler' => $associado->first()->id_pessoa.'QD05LT12',
            'situacao' => 'Provisionado',
            'agrupado' => 0,
            'aceite' => 0,
            'especie_doc' => 'DM'
        ]);

        $carteira->nosso_numero_inicio = $carteira->nosso_numero_inicio + 1;
        $carteira->update();
        \DB::commit();
        set_time_limit(30);
    }

    public function printPendenciasSC(Request $conteudo)
    {
        $html = '<html><body><h1>Pendências na geração da simulação do cálculo</h1>'.$conteudo["html"].'</body></html>';
        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 10, 15, 1, 8);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    private function estornarFluxoTemporario($id_parcela)
    {
        $fluxo_caixa = FluxoCaixa::where('id_parcela',$id_parcela)->get();
        $fluxo_caixa->delete();
    }

}
