<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Helpers\DataHelper;
use App\Models\Acordo;
use App\Models\AcordoParcelasNegociadas;
use App\Models\ContasReceber;
use App\Models\Empresa;
use App\Models\GrupoProduto;
use App\Models\Imovel;
use App\Models\ImovelPermanente;
use App\Models\Lancamento;
use App\Models\LancamentoAgendar;
use App\Models\LancamentosContaReceber;
use App\Models\ParcelaBoleto;
use App\Models\ParcelaPagar;
use App\Models\Pessoa;
use App\Models\PessoaPermanente;
use App\Models\Produto;
use App\Models\Recebimento;
use App\Models\RecebimentoParcela;
use App\Models\Receita;
use App\Models\TipoDocumento;
use App\Models\TipoLancamento;
use Carbon\Carbon;
use Doctrine\DBAL\Driver\PDOException;
use Faker\Provider\DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use League\Flysystem\Exception;
use Psy\Exception\ErrorException;
use Respect\Validation\Rules\Date;

class MigrationDatabaseClientController extends Controller
{
    private $check_noss_num;
    private $configuracao_receita;
    private $imoveis_n_encontrados =[];
    private $pessoas_n_encontrados = [];
    private $qtd_imovel_n_econtrado =0;
    private $qtd_pessoa_n_econtrada = 0;
    private $conta_receber;
    private $recebimento;
    private $recebimento_parcela;
    private $parcela_boleto;

    public function importDabaseVerona()
    {
        //Busca configurações de receitas
        $configuracao_receita = Receita::first();
        if(!count($configuracao_receita)) {
            return response()->error("Configuração receita invalida.");
        }
        //Conectar com o banco externo
        $conn = $this->conectaMysql();
        if($conn == "Connection failed"){
            return response("Não foi possivel conectar!");
        }

        try {

            set_time_limit(0);

            //Busca todos os boletos que não são de acordo e nem parcela
            $result = $conn->query("SELECT * FROM banco_taxas WHERE Acordo IS NULL OR Acordo = '' ");
            $incluido = 0;
            $resultado =[];

            $nao_incluido = 0;
            $boletos_nao_cadastrado=[];
            \DB::beginTransaction();
            //Pecorre todos os boletos
            while ($linha = $result->fetch(\PDO::FETCH_ASSOC)) {

                //Busca o imovel
                $imovel = Imovel::with(array('imoveis_permanentes' => function ($q) {
                    $q->where('pessoa_titular', 1);
                }))->where(\DB::raw('abs(quadra)'), '=', $linha['Quadra'])
                    ->where(\DB::raw('abs(lote)'), $linha['Lote'])->get()->first();
                //Verifica se o imovel existe
                if (count($imovel)) {
                    if (strlen($linha['Nosso_Gerado'])>7) {
                        $linha['Nosso_Gerado'] = substr($linha['Nosso_Gerado'], 0, -1);
                    }
                    //Tenta encontrar o boleto pelo nosso numero
                    $titulo = ParcelaBoleto::where('nosso_numero', '=', (integer)$linha['Nosso_Gerado'])->first();
                    if (!count($titulo)) {
                        $titulo = ParcelaBoleto::where('nosso_numero', 'like', '%' . $linha['Nosso_Gerado'] . '%')->first();
                    }
                    //Verifica se o boleto foi encontrado
                    if (!count($titulo)) {
                        //Cria uma conta receber
                        $conta_receber = new  ContasReceber();
                        $conta_receber->valor_total = $linha['Valor'];
                        $conta_receber->valor_original = $linha['Valor'];
                        $conta_receber->total_provisionado = $linha['Valor'];
                        $conta_receber->data_agendamento = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtVenc'])->format('d/m/Y');
                        $conta_receber->id_imovel = $imovel->id;
                        $conta_receber->save();

                        //Criar os lançamentos
                        if (!empty($linha['Taxa']) && $linha['Taxa'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 1,
                                'saldo_receber' => 0,
                                'descricao' => 'Taxa Manutenção m2' ,
                                'valor' => $linha['Taxa'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Taxa')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['FReserva']) && $linha['FReserva'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 2,
                                'saldo_receber' => 0,
                                'descricao' => 'Fundo de Reserva',
                                'valor' => $linha['FReserva'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Fundo')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Multa']) && $linha['Multa'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoMulta->descricao,
                                'valor' => $linha['Multa'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Juros']) && $linha['Juros'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoJuros->descricao,
                                'valor' => $linha['Juros'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Juridico']) && $linha['Juridico'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 9,
                                'saldo_receber' => 0,
                                'descricao' => 'HONORÁRIO',
                                'valor' => $linha['Juridico'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Juridico')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Custas']) && $linha['Custas'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocustasadicionais,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoCustasAdicionais->descricao,
                                'valor' => $linha['Custas'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Custas')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Abatimento']) && $linha['Abatimento'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                'valor' => $linha['Abatimento'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Descontos']) && $linha['Descontos'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                'valor' => $linha['Descontos'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Lancamentos']) && $linha['Lancamentos'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 22,
                                'saldo_receber' => 0,
                                'descricao' => 'OUTROS',
                                'valor' => $linha['Lancamentos'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Outros')
                            ]);
                            $conta_receber->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        //Cria um recebimento
                        $recebimento = new Recebimento();
                        $recebimento->id_configuracao_carteira = $configuracao_receita->carteiraBancaria->id;
                        $recebimento->id_layout_remessa = $configuracao_receita->carteiraBancaria->id_carteira;
                        $recebimento->idimovel = $imovel->id;
                        $recebimento->idassociado = $imovel->imoveis_permanentes->first()->id_pessoa;
                        $recebimento->data_agendamento = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtVenc'])->format('d/m/Y');
                        $recebimento->numero_parcelas = 1;
                        $recebimento->save();

                        //Inclui lançamentos
                        foreach ($conta_receber->lancamentos as $lancamento) {
                            $recebimento->lancamentos()->attach($lancamento->pivot->id);
                        }

                        //Inclui Parcela
                        $recebimento_parcela = new RecebimentoParcela();
                        $recebimento_parcela->valor = $conta_receber->valor_total;
                        $recebimento_parcela->valor_origem = $conta_receber->valor_total;
                        $recebimento_parcela->id_recebimento = $recebimento->id;
                        $recebimento_parcela->forma_pagamento = 'TITULO';
                        $recebimento_parcela->id_situacao_inadimplencia = 1;
                        $recebimento_parcela->created_at = $linha['DtVenc'];
                        $recebimento_parcela->save();

                        //Boleto
                        $titulo = new ParcelaBoleto();
                        $titulo->id_parcela = $recebimento_parcela->id;
                        $titulo->data_vencimento = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtVenc'])->format('d/m/Y');
                        $titulo->data_vencimento_origem = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtVenc'])->format('d/m/Y');
                        $titulo->percentualmulta = $configuracao_receita->percentualmulta;//2.8
                        $titulo->percentualjuros = $configuracao_receita->percentualmulta;//1.14
                        $titulo->juros_apos = 1;
                        $titulo->dias_protesto = false;
                        $titulo->nosso_numero = $linha["Nosso_Gerado"];
                        $titulo->numero_documento = $linha["Recebimentos_Nosso"];
                        //Verifica se boleto foi recebido
                        if (!empty($linha['Recebido']) && $linha['Recebido'] > 0) {
                            $titulo->situacao = "Compensado";
                            $recebimento_parcela->valor_recebido = $linha['Recebido'];
                            $recebimento_parcela->data_compensado = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtPgto'])->format('d/m/Y');
                            $recebimento_parcela->data_recebimento = Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtPgto'])->format('d/m/Y');
                            $recebimento_parcela->update();
                        } else {
                            $titulo->situacao = "Provisionado";
                        }

                        $titulo->agrupado = 0;
                        $titulo->aceite = 0;//0(zero)
                        $titulo->especie_doc = 'DM';
                        $titulo->save();
                        $incluido++;
                    } else {

                        if (!empty($linha['Recebido']) && $linha['Recebido'] > 0) {
                            $lanc_juros_id = false;
                            $lanc_multa_id = false;
                            //verifica se já existe lançamentos do tipo juros e multa

                            foreach ($titulo->parcela->recebimento->lancamentos as $item){
                                if($item->lancamento->categoria == 6){
                                    $lanc_juros_id = $item->lancamento->id;
                                }
                                if($item->lancamento->categoria == 5){
                                    $lanc_multa_id = $item->lancamento->id;
                                }
                            }


                            if (!empty($linha['Multa']) && $linha['Multa'] > 0) {
                                if ($lanc_multa_id){
                                    //faça update do lançamento de juros
                                    $up_lanc_multa = Lancamento::find($lanc_multa_id);
                                    $up_lanc_multa->descricao =$configuracao_receita->tipoLancamentoMulta->descricao;
                                    $up_lanc_multa->valor = $linha["Multa"];
                                    $up_lanc_multa->save();
                                } else {
                                    $lancamento = Lancamento::create([
                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                                        'saldo_receber' => 0,
                                        'descricao' => $configuracao_receita->tipoLancamentoMulta->descricao,
                                        'valor' => $linha['Multa'],
                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                                    ]);
                                    $lancamento_receber = LancamentosContaReceber::create([
                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos->first()->conta_receber->id,
                                        'id_lancamento' => $lancamento->id
                                    ]);
                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                    unset($lancamento);
                                    unset($lancamento_receber);
                                }
                            }

                            if (!empty($linha['Juros']) && $linha['Juros'] > 0) {
                                if ($lanc_juros_id){
                                    //faça update do lançamento de juros
                                    $up_lanc_jur = Lancamento::find($lanc_juros_id);
                                    $up_lanc_jur->descricao =$configuracao_receita->tipoLancamentoJuros->descricao;
                                    $up_lanc_jur->valor = $linha["Juros"];
                                    $up_lanc_jur->save();
                                } else {
                                    $lancamento = Lancamento::create([
                                        'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                                        'saldo_receber' => 0,
                                        'descricao' => $configuracao_receita->tipoLancamentoJuros->descricao,
                                        'valor' => $linha['Juros'],
                                        'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                                    ]);
                                    $lancamento_receber = LancamentosContaReceber::create([
                                        'id_conta_receber' => $titulo->parcela->recebimento->lancamentos->first()->conta_receber->id,
                                        'id_lancamento' => $lancamento->id
                                    ]);
                                    $titulo->parcela->recebimento->lancamentos()->attach($lancamento_receber->id);
                                    unset($lancamento);
                                    unset($lancamento_receber);
                                }
                            }

                            $titulo->situacao = "Compensado";
                            error_log($titulo);
                            $titulo->parcela->recebimento->lancamentos()->first()->conta_receber->update([
                                'total_recebido' => $linha['Recebido']
                            ]);

                            $titulo->parcela->update([
                                'valor_recebido'=>$linha['Recebido'],
                                'data_compensado'=> Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtPgto'])->format('d/m/Y'),
                                'data_recebimento'=> Carbon::createFromFormat('Y-m-d H:i:s', $linha['DtPgto'])->format('d/m/Y')
                            ]);
                            $titulo->update();
                        }
                        $nao_incluido++;
                        $boletos_nao_cadastrado[] = [
                            'Nosso_Gerado' => $linha["Nosso_Gerado"],
                            'Identificacao' => $linha["Identificacao"]
                        ];

                    }
                }
            }
//            \DB::commit();
//            return response('conluido');


            $resultado['boletos_cadastrados'] = $incluido;
            $resultado['qtd_boletos_nao_cadastrado'] = $nao_incluido;


            // Busca os associados que tem acordo
            $result = $conn->query("SELECT Associado, Quadra, Lote FROM banco_taxas WHERE Acordo = 'Acordo' GROUP BY Associado ");

            $qtd_acordo = 0;
            $incluido = 0;
            $qtd_existente =0;
            //Pecorre todos os associados que tem o acordo
            while ($linha = $result->fetch(\PDO::FETCH_ASSOC)) {
                //Busca o Imovel
                $imovel = Imovel::with(array('imoveis_permanentes' => function($q){
                    $q->where('pessoa_titular',1);
                }))->where(\DB::raw('abs(quadra)'),'=',$linha['Quadra'])
                    ->where(\DB::raw('abs(lote)'), $linha['Lote'])->get()->first();

                //Verifica se esse imovel exite
                if(count($imovel)) {
                    //Busca e inclui os titulos negociadas
                    $titulos_acordados = $conn->query("SELECT * FROM banco_taxas WHERE Quadra = ". $linha['Quadra'] ." AND Lote = '".$linha['Lote']."' AND Acordo = 'Acordo' ");

                    // Pecorre os titulos encontrados e cadastro no sistema
                    $parcelas_negociadas = [];
                    $valor_divida = 0;
                    while ($titulo_acordado = $titulos_acordados->fetch(\PDO::FETCH_ASSOC)) {
                        if (strlen($titulo_acordado['Nosso_Gerado'])>7) {
                            $titulo_acordado['Nosso_Gerado'] = substr($titulo_acordado['Nosso_Gerado'], 0, -1);
                        }
                        $titulo = ParcelaBoleto::where('nosso_numero', '=', (integer)$titulo_acordado['Nosso_Gerado'])->first();
                        if (!count($titulo)) {
                            $titulo = ParcelaBoleto::where('nosso_numero', 'like', '%' . $titulo_acordado['Nosso_Gerado'] . '%')->first();
                        }

                        if (!count($titulo)) {
                            //Cria uma conta receber
                            $conta_receber = new  ContasReceber();
                            $conta_receber->valor_total = $titulo_acordado['Valor'];
                            $conta_receber->valor_original = $titulo_acordado['Valor'];
                            $conta_receber->total_provisionado = $titulo_acordado['Valor'];
                            $conta_receber->data_agendamento = Carbon::createFromFormat('Y-m-d H:i:s', $titulo_acordado['DtVenc'])->format('d/m/Y');
                            $conta_receber->id_imovel = $imovel->id;
                            $conta_receber->save();

                            //Criar os lançamentos
                            if (!empty($titulo_acordado['Taxa']) && $titulo_acordado['Taxa'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => 1,
                                    'saldo_receber' => 0,
                                    'descricao' => 'Taxa Manutenção m2' ,
                                    'valor' => $titulo_acordado['Taxa'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Taxa')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['FReserva']) && $titulo_acordado['FReserva'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => 2,
                                    'saldo_receber' => 0,
                                    'descricao' => 'Fundo de Reserva',
                                    'valor' => $titulo_acordado['FReserva'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Fundo')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Multa']) && $titulo_acordado['Multa'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                                    'saldo_receber' => 0,
                                    'descricao' => $configuracao_receita->tipoLancamentoMulta->descricao,
                                    'valor' => $titulo_acordado['Multa'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Juros']) && $titulo_acordado['Juros'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                                    'saldo_receber' => 0,
                                    'descricao' => $configuracao_receita->tipoLancamentoJuros->descricao,
                                    'valor' => $titulo_acordado['Juros'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Juridico']) && $titulo_acordado['Juridico'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => 9,
                                    'saldo_receber' => 0,
                                    'descricao' => 'HONORÁRIO',
                                    'valor' => $titulo_acordado['Juridico'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Juridico')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Custas']) && $titulo_acordado['Custas'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocustasadicionais,
                                    'saldo_receber' => 0,
                                    'descricao' => $configuracao_receita->tipoLancamentoCustasAdicionais->descricao,
                                    'valor' => $titulo_acordado['Custas'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Custas')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Abatimento']) && $titulo_acordado['Abatimento'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                    'saldo_receber' => 0,
                                    'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                    'valor' => $titulo_acordado['Abatimento'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Desconto')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($titulo_acordado['Descontos']) && $titulo_acordado['Descontos'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                    'saldo_receber' => 0,
                                    'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                    'valor' => $titulo_acordado['Descontos'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }

                            if (!empty($linha['Lancamentos']) && $linha['Lancamentos'] > 0) {
                                $lancamento = Lancamento::create([
                                    'idtipo_lancamento' => 22,
                                    'saldo_receber' => 0,
                                    'descricao' => 'OUTROS',
                                    'valor' => $linha['Lancamentos'],
                                    'categoria' => EnumCategoriaLancamento::toOrdinal('Outros')
                                ]);
                                $conta_receber->lancamentos()->attach($lancamento->id);
                                unset($lancamento);
                            }


                            $recebimento = new Recebimento();
                            $recebimento->id_configuracao_carteira = $configuracao_receita->carteiraBancaria->id;
                            $recebimento->id_layout_remessa = $configuracao_receita->carteiraBancaria->id_carteira;
                            $recebimento->idimovel = $imovel->id;
                            $recebimento->idassociado = $imovel->imoveis_permanentes->first()->id_pessoa;
                            $recebimento->data_agendamento = Carbon::createFromFormat('Y-m-d H:i:s', $titulo_acordado['DtVenc'])->format('d/m/Y');
                            $recebimento->numero_parcelas = 1;
                            $recebimento->save();

                            foreach ($conta_receber->lancamentos as $lancamento) {
                                $recebimento->lancamentos()->attach($lancamento->pivot->id);
                            }

//                            $recebimento_parcela = new RecebimentoParcela();
//                            $recebimento_parcela->valor = $conta_receber->valor_total;
//                            $recebimento_parcela->id_recebimento = $recebimento->id;
//                            $recebimento_parcela->forma_pagamento = 'TITULO';
//                            $recebimento_parcela->save();

                            $recebimento_parcela = RecebimentoParcela::create([
                                'valor' => $conta_receber->valor_total,
                                'valor_origem'=> $conta_receber->valor_total,
                                'id_recebimento' => $recebimento->id,
                                'forma_pagamento' => 'TITULO',
                                'created_at' => $titulo_acordado['DtVenc'],
                                'id_situacao_inadimplencia'=> $configuracao_receita->id_tipoinadimplenciapadrao
                            ]);

                            $titulo = ParcelaBoleto::create([
                                'id_parcela' => $recebimento_parcela->id,
                                'data_vencimento' => Carbon::createFromFormat('Y-m-d H:i:s', $titulo_acordado['DtVenc'])->format('d/m/Y'),
                                'data_vencimento_origem' => Carbon::createFromFormat('Y-m-d H:i:s', $titulo_acordado['DtVenc'])->format('d/m/Y'),
                                'percentualmulta' => $configuracao_receita->percentualmulta,
                                'percentualjuros' => $configuracao_receita->percentualjuros,
                                'juros_apos' => 1,
                                'dias_protesto' => false,
                                'nosso_numero' => $titulo_acordado["Nosso_Gerado"],
                                'numero_documento' =>  $titulo_acordado["Recebimentos_Nosso"],
                                'situacao' => 'Negociado',
                                'agrupado' => 0,
                                'aceite' => 0,
                                'especie_doc' => 'DM'
                            ]);




//                            $titulo = new ParcelaBoleto();
//                            $titulo->id_parcela = $recebimento_parcela->id;
//                            $titulo->data_vencimento = Carbon::createFromFormat('Y-m-d H:i:s', $titulo_acordado['DtVenc'])->format('d/m/Y');
//                            $titulo->percentualmulta = $configuracao_receita->percentualmulta;//2.8
//                            $titulo->percentualjuros = $configuracao_receita->percentualmulta;//1.14
//                            $titulo->juros_apos = 1;
//                            $titulo->dias_protesto = false;
//                            $titulo->nosso_numero = $titulo_acordado["Nosso_Gerado"];
//                            $titulo->numero_documento = $titulo_acordado["Recebimentos_Nosso"];
//                            $titulo->situacao = "Negociado";
//                            $titulo->agrupado = 0;
//                            $titulo->aceite = 0;//0(zero)
//                            $titulo->especie_doc = 'DM';
//                            $titulo->save();
                            $parcelas_negociadas[] = $recebimento_parcela->id;
                            $incluido++;
                        } else {
                            $parcelas_negociadas[] = $titulo->id_parcela;
                            $qtd_existente++;
                        }

                        $valor_divida = $valor_divida + $titulo_acordado['Valor'];
                    }

                    //Busca e incluir as parcelas do acordo
                    $parcelas_acordo= $conn->query("SELECT * FROM banco_taxas WHERE Quadra = ". $linha['Quadra'] ." AND Lote = '".$linha['Lote']."' AND Acordo = 'Parcela Acordo' ");

                    $conta_receber_acordo = new  ContasReceber();
                    $conta_receber_acordo->valor_total = 0;
                    $conta_receber_acordo->valor_original = 0;
                    $conta_receber_acordo->total_provisionado = 0;
                    $conta_receber_acordo->data_agendamento = date('d/m/Y');
                    $conta_receber_acordo->id_imovel = $imovel->id;
                    $conta_receber_acordo->save();

                    $recebimento_acordo = new Recebimento();
                    $recebimento_acordo->id_configuracao_carteira = 1;
                    $recebimento_acordo->id_layout_remessa = 1;
                    $recebimento_acordo->idimovel = $imovel->id;
                    $recebimento_acordo->idassociado = $imovel->imoveis_permanentes->first()->id_pessoa;
                    $recebimento_acordo->data_agendamento = date('d/m/Y');
                    $recebimento_acordo->numero_parcelas = 0;
                    $recebimento_acordo->save();

                    $qtd_parcelas = 0;
                    $valor_acordo = 0;
                    while ($parcela_acordo = $parcelas_acordo->fetch(\PDO::FETCH_ASSOC)) {
                        if (strlen($parcela_acordo['Nosso_Gerado'])>7) {
                            $parcela_acordo['Nosso_Gerado'] = substr($parcela_acordo['Nosso_Gerado'], 0, -1);
                        }
                        $titulo = ParcelaBoleto::where('nosso_numero', '=', (integer)$parcela_acordo['Nosso_Gerado'])->first();
                        if (!count($titulo)) {
                            $titulo = ParcelaBoleto::where('nosso_numero', 'like', '%' . $parcela_acordo['Nosso_Gerado'] . '%')->first();
                        }
                        //Criar os lançamentos
                        if (!empty($parcela_acordo['Taxa']) && $parcela_acordo['Taxa'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 1,
                                'saldo_receber' => 0,
                                'descricao' => 'Taxa Manutenção m2' ,
                                'valor' => $parcela_acordo['Taxa'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Taxa')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['FReserva']) && $parcela_acordo['FReserva'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 2,
                                'saldo_receber' => 0,
                                'descricao' => 'Fundo de Reserva',
                                'valor' => $parcela_acordo['FReserva'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Fundo')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Multa']) && $parcela_acordo['Multa'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentomulta,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoMulta->descricao,
                                'valor' => $parcela_acordo['Multa'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Juros']) && $parcela_acordo['Juros'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentojuros,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoJuros->descricao,
                                'valor' => $parcela_acordo['Juros'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Juridico']) && $parcela_acordo['Juridico'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 9,
                                'saldo_receber' => 0,
                                'descricao' => 'HONORÁRIO',
                                'valor' => $parcela_acordo['Juridico'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Juridico')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Custas']) && $parcela_acordo['Custas'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentocustasadicionais,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoCustasAdicionais->descricao,
                                'valor' => $parcela_acordo['Custas'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Custas')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Abatimento']) && $parcela_acordo['Abatimento'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                'valor' => $parcela_acordo['Abatimento'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Desconto')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($parcela_acordo['Descontos']) && $parcela_acordo['Descontos'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => $configuracao_receita->id_tipolancamentodesconto,
                                'saldo_receber' => 0,
                                'descricao' => $configuracao_receita->tipoLancamentoDesconto->descricao,
                                'valor' => $parcela_acordo['Descontos'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!empty($linha['Lancamentos']) && $linha['Lancamentos'] > 0) {
                            $lancamento = Lancamento::create([
                                'idtipo_lancamento' => 22,
                                'saldo_receber' => 0,
                                'descricao' => 'OUTROS',
                                'valor' => $linha['Lancamentos'],
                                'categoria' => EnumCategoriaLancamento::toOrdinal('Outros')
                            ]);
                            $conta_receber_acordo->lancamentos()->attach($lancamento->id);
                            unset($lancamento);
                        }

                        if (!count($titulo)) {
                            $recebimento_parcela = new RecebimentoParcela();
                            $recebimento_parcela->valor = $parcela_acordo["Valor"];
                            $recebimento_parcela->id_recebimento = $recebimento_acordo->id;
                            $recebimento_parcela->forma_pagamento = 'TITULO';
                            $recebimento_parcela->created_at = $parcela_acordo['DtVenc'];
                            $recebimento_parcela->save();

                            $titulo = new ParcelaBoleto();
                            $titulo->id_parcela = $recebimento_parcela->id;
                            $titulo->data_vencimento = Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtVenc'])->format('d/m/Y');
                            $titulo->data_vencimento_origem = Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtVenc'])->format('d/m/Y');
                            $titulo->percentualmulta = $configuracao_receita->percentualmulta;//2.8
                            $titulo->percentualjuros = $configuracao_receita->percentualmulta;//1.14
                            $titulo->juros_apos = 1;
                            $titulo->dias_protesto = false;
                            $titulo->nosso_numero = $parcela_acordo["Nosso_Gerado"];
                            $titulo->numero_documento = $parcela_acordo["Recebimentos_Nosso"];
                            if (!empty($parcela_acordo['Recebido']) && $parcela_acordo['Recebido'] > 0) {
                                $titulo->situacao = "Compensado";
                                $recebimento_parcela->valor_recebido = $parcela_acordo['Recebido'];
                                $recebimento_parcela->data_compensado = Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtPgto'])->format('d/m/Y');
                                $recebimento_parcela->data_recebimento = Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtPgto'])->format('d/m/Y');
                                $recebimento_parcela->update();
                            } else {
                                $titulo->situacao = "Provisionado";
                            }
                            $titulo->agrupado = 0;
                            $titulo->aceite = 0;//0(zero)
                            $titulo->especie_doc = 'DM';
                            $titulo->save();

                        } else {
                            if (!empty($parcela_acordo['Recebido']) && $parcela_acordo['Recebido'] > 0) {
                                $titulo->situacao = "Compensado";
                                $titulo->parcela->update([
                                    'id_recebimento' => $recebimento_acordo->id,
                                    'valor_recebido' => $parcela_acordo['Recebido'],
                                    'data_compensado' => Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtPgto'])->format('d/m/Y'),
                                    'data_recebimento' => Carbon::createFromFormat('Y-m-d H:i:s', $parcela_acordo['DtPgto'])->format('d/m/Y')
                                ]);
                            } else {
                                $titulo->parcela->update([
                                    'id_recebimento' => $recebimento_acordo->id
                                ]);

                                $titulo->situacao = "Provisionado";
                            }
                            $titulo->update();
                            $qtd_existente++;
                        }

                        $valor_acordo = $valor_acordo + $parcela_acordo["Valor"];
                        $qtd_parcelas++;
                    }

                    foreach ($conta_receber_acordo->lancamentos as $lancamento) {
                        $recebimento_acordo->lancamentos()->attach($lancamento->pivot->id);
                    }

                    $conta_receber_acordo->valor_total = $valor_acordo;
                    $conta_receber_acordo->valor_original = $valor_acordo;
                    $conta_receber_acordo->total_provisionado = $valor_acordo;
                    $conta_receber_acordo->update();

                    $recebimento_acordo->numero_parcelas = $qtd_parcelas;
                    $recebimento_acordo->update();

                    //grava dados do acordo
                    $acordo = new Acordo();
                    $acordo->id_associado = $imovel->imoveis_permanentes->first()->id_pessoa;
                    $acordo->id_imovel = $imovel->id;
                    $acordo->id_recebimento = $recebimento_acordo->id;
                    $acordo->nome_parceiro = $linha["Associado"];
                    $acordo->forma_pagamento = 'TITULO';
                    $acordo->data_acordo = date('d/m/Y');
                    $acordo->data_agendamento = date('d/m/Y');
                    $acordo->valor_divida = $valor_divida;
                    $acordo->valor_acordo = $valor_acordo;
                    $acordo->valor_entrada =  null;
                    $acordo->data_recebimento_entrada = NULL;
                    $acordo->comprovante_entrada = null;
                    $acordo->status = 1;

                    $acordo->save();

                    //muda o status dos boletos negociados
                    ParcelaBoleto::whereIn('id_parcela',$parcelas_negociadas)->update(['situacao' => 'Negociado']);
                    //relaciona o recebimento gerado  do acordo com o as parcelas negociadas
                    foreach ($parcelas_negociadas as $id) {
                        $acordo_negociadas = new AcordoParcelasNegociadas();
                        $acordo_negociadas->id_acordo = $acordo->id;
                        $acordo_negociadas->id_parcela_negociada = $id;
                        $acordo_negociadas->save();
                    }
                    $qtd_acordo ++;
                }
            }

            $resultado['boletos_cadastrados'] = $resultado['boletos_cadastrados'] + $incluido;
            $resultado['qtd_boletos_nao_cadastrado'] = $resultado['qtd_boletos_nao_cadastrado'] +  $nao_incluido;
            $resultado['qtd_acordo'] = $qtd_acordo;
            $resultado['qtd_existente'] = $qtd_existente;
            $resultado['boletos_nao_cadastrado'] = $boletos_nao_cadastrado;

            set_time_limit(30);
            \DB::commit();
            return $resultado;
        } catch (Exception $e) {
            \DB::rollBack();
            set_time_limit(30);
            return response("Problemas");
        } catch (ErrorException $err){
            return response($err);
        }

    }

    public  function  conectaMysql()
    {
        $servername = "localhost";
        $username = "root";
        $password = "";

        try {
            $conn = new \PDO("mysql:host=$servername;dbname=jardins_madri_migracao", $username, $password);
            $conn->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
            return $conn;
        }
        catch(PDOException $e)
        {
            return "Connection failed";
        }
    }

    public function importDatabaseGreenPark()
    {
        //Busca configurações de receitas
        $configuracao_receita = Receita::first();
        if(!count($configuracao_receita)) {
            return response()->error("Configuração receita invalida.");
        }
        //Conectar com o banco externo
        $conn = $this->conectaMysql();
        if($conn == "Connection failed"){
            return response("Não foi possivel conectar!");
        }

        try {
            set_time_limit(0);
            //Busca todos os boletos que não são de acordo e nem parcela
            $result = $conn->query("SELECT * FROM banco_taxas");
            $incluido = 0;
            $resultado =[];

            $nao_incluido = 0;
            $boletos_nao_cadastrado=[];
            \DB::beginTransaction();
            while ($linha = $result->fetch(\PDO::FETCH_ASSOC)) {

            }

            set_time_limit(30);
            \DB::commit();
            return $resultado;
        } catch (Exception $e) {
            \DB::rollBack();
            set_time_limit(30);
            return response("Problemas");
        } catch (ErrorException $err){
            return response($err);
        }
    }

    private function getNextRow($proximoId)
    {
        return \DB::table('import_receitas')->where('id_receita', $proximoId)->first();
    }

    public function importCSVReceitasjdsMadri($ano_competencia)
    {
        echo 'Início: '.date('H:i:s').'<br>';
        \Log::info('Início: '.date('H:i:s').'<br>');
        ## Código LOAD DATA
        /*$arquivo = storage_path('app/importCSV/receitas.csv');
        //primeiro crie a tabela no banco com as colunas necessárias
        //comando SQL retira a primeira linha que geralmente vem com os nomes das colunas
        $import = \DB::statement("LOAD DATA LOCAL INFILE '$arquivo'
                                        INTO TABLE jardins_verona2.import FIELDS TERMINATED BY ';' IGNORE 1 LINES");
        return $import;*/




//        //Conectar com o banco externo
//        $conn = $this->conectaMysql();
//        $result = $conn->query("SELECT * FROM import");
//        while ($linha = $result->fetch(\PDO::FETCH_ASSOC)){
//            var_dump($linha);
//            exit();
//            ob_flush();
//        }
//exit();

//        $import = \DB::table('import')->get();
        set_time_limit(0);
        ini_set("memory_limit", -1);
        //Busca configurações de receitas
        $this->configuracao_receita = Receita::first();
        if(!count($this->configuracao_receita)) {
            return response()->error("Configuração receita invalida.");
        }
        $this->check_noss_num = 0;

//        try {
            \DB::beginTransaction();
            $i = 0;
           // \DB::table('import_receitas')->where('ano_competencia','>=',$ano_competencia)->orderBy('agrp_boleto')->chunk(2, function ($import) use($i) {
                /*$import = \DB::table('import_receitas')
                    ->where('ano_competencia','<=',$ano_competencia)
                    ->where('dt_cancelamento','=','')
                    ->where('dt_compensacao','=','')
                    ->orderBy('agrp_boleto')
                    ->get();*/
        \DB::table('import_receitas')
            ->where('dt_cancelamento','=','')
            ->where('dt_compensacao','!=','')
            ->where('ano_competencia',$ano_competencia)
            ->orderBy('agrp_boleto')->chunk(10000, function ($import) use($i) {

                foreach ($import as $dados) {
//                    if ($this->check_noss_num > 0){
//
//                        if ($this->check_noss_num != $dados->nosso_numero) {
//                            var_dump($import);
//                            die();
//                        } else {
//                            var_dump('false');
//                            die();
//                        }
//                    }

                    //$dados = $this->getNextRow($item->id_receita);
                    $id_imovel = 0;

                    $imovel = Imovel::where('quadra', '=', $dados->quadra)
                        ->where(\DB::raw('abs(lote)'), $dados->lote)->first();

                    if(count($imovel)){
                        $id_imovel = $imovel->id;
                    } else {
                        $id_imovel = 1;
                        $this->imoveis_n_encontrados[$i] = ['quadra'=>$dados->quadra, 'lote'=>$dados->lote, 'nosso_numero'=> $dados->nosso_numero, 'parceiro'=>$dados->parceiro];
                        $this->qtd_imovel_n_econtrado = $this->qtd_imovel_n_econtrado +1;
                    }
                    //Verifica se é um novo nosso numero para criar uma nova conta
                    if ($this->check_noss_num != $dados->nosso_numero) {
                        //Cria uma conta receber
                        $this->conta_receber = new  ContasReceber();
                        $this->conta_receber->valor_total = DataHelper::getRealToDouble($dados->valor_boleto);
                        $this->conta_receber->valor_original = DataHelper::getRealToDouble($dados->valor_boleto);
                        $this->conta_receber->total_provisionado = DataHelper::getRealToDouble($dados->valor_boleto);
                        $this->conta_receber->data_agendamento = DataHelper::setDateTimeToDate($dados->dt_base);
                        $this->conta_receber->id_imovel = $id_imovel;
                        $this->conta_receber->save();
                    }

                    //Criar os lançamentos
                    if ($dados->descricao === 'Taxa de Manutenção m2 ') {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => 1,
                            'saldo_receber' => 0,
                            'descricao' =>  'Taxa Manutenção m2',
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Taxa')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } elseif ($dados->descricao === 'Fundo de Reserva') {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => 2,
                            'saldo_receber' => 0,
                            'descricao' => 'Fundo de Reserva',
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Fundo')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } elseif (preg_match('/multa/', $dados->descricao)) {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => $this->configuracao_receita->id_tipolancamentomulta,
                            'saldo_receber' => 0,
                            'descricao' =>  $dados->descricao,
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Multa')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } elseif ($dados->descricao === 'Juros') {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => $this->configuracao_receita->id_tipolancamentojuros,
                            'saldo_receber' => 0,
                            'descricao' =>  'Juros',
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Juros')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } elseif (preg_match('/custos/', $dados->descricao)) {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => $this->configuracao_receita->id_tipolancamentocustasadicionais,
                            'saldo_receber' => 0,
                            'descricao' =>  $dados->descricao,
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Custas')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } elseif ($dados->descricao === 'Abatimento' || preg_match('/desconto/', $dados->descricao)) {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => $this->configuracao_receita->id_tipolancamentodesconto,
                            'saldo_receber' => 0,
                            'descricao' =>  $this->configuracao_receita->tipoLancamentoDesconto->descricao,
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Descontos')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    } else {
                        $lancamento = Lancamento::create([
                            'idtipo_lancamento' => 10,
                            'saldo_receber' => 0,
                            'descricao' =>  $dados->descricao,
                            'valor' => DataHelper::getRealToDouble($dados->valor_debito),
                            'categoria' => EnumCategoriaLancamento::toOrdinal('Outros')
                        ]);
                        $this->conta_receber->lancamentos()->attach($lancamento->id);
                        unset($lancamento);
                    }

                    if ($this->check_noss_num != $dados->nosso_numero) {
                        $id_pessoa = 0;
                        $associado_hoje =  \DB::table('import_parceiro')->select(['nome','cpf'])->where('id', $dados->cod_parceiro)->first();
                        $pessoa = \DB::table('pessoa')->where('cpf', $associado_hoje->cpf)->orWhere('nome',$associado_hoje->nome)->first();
                        if(count($pessoa)){
                            $id_pessoa = $pessoa->id;
                        } else {
                            $this->pessoas_n_encontrados[$i] = ['nome'=>$associado_hoje->nome, 'cpf'=>$associado_hoje->cpf, 'quadra'=>$dados->quadra, 'lote'=>$dados->lote, 'nosso_numero'=> $dados->nosso_numero, 'parceiro'=>$dados->parceiro];
                            $this->qtd_pessoa_n_econtrada = $this->qtd_pessoa_n_econtrada +1;
                            $id_pessoa = 1;
                        }
                        //Cria um recebimento
                        $this->recebimento = new Recebimento();
                        $this->recebimento->id_configuracao_carteira = $this->configuracao_receita->carteiraBancaria->id;
                        $this->recebimento->id_layout_remessa = $this->configuracao_receita->carteiraBancaria->id_layout_remessa;
                        $this->recebimento->idimovel = $id_imovel;
                        $this->recebimento->idassociado = $id_pessoa;
                        $this->recebimento->data_agendamento = DataHelper::setDateTimeToDate($dados->dt_base);
                        $this->recebimento->numero_parcelas = $dados->total_parcelas;
                        $this->recebimento->save();

                    }

//                    //Pega o último lancamento_conta_receber cadastrado e Inclui lançamentos-recebimento
                    $lanc_c_r = \DB::table('lancamentos_contas_receber')->latest()->first();
                    $this->recebimento->lancamentos()->attach($lanc_c_r->id);
                    /*foreach ($this->>conta_receber->lancamentos as $lancamento) {
                        $this->recebimento->lancamentos()->attach($lancamento->pivot->id);
                    }*/
                    if ($this->check_noss_num != $dados->nosso_numero) {
                        //Inclui Parcela
                        $this->recebimento_parcela = new RecebimentoParcela();
                        $this->recebimento_parcela->valor = $this->conta_receber->valor_total;
                        $this->recebimento_parcela->valor_origem = $this->conta_receber->valor_total;
                        $this->recebimento_parcela->id_recebimento = $this->recebimento->id;
                        $this->recebimento_parcela->forma_pagamento = 'TITULO';
                        $this->recebimento_parcela->id_situacao_inadimplencia = 1;
                        $this->recebimento_parcela->save();

                        //Boleto
                        $this->parcela_boleto = new ParcelaBoleto();
                        $this->parcela_boleto->id_parcela = $this->recebimento_parcela->id;
                        // \Log::info($dados->dt_venc_boleto);
                        $this->parcela_boleto->data_vencimento = DataHelper::setDateTimeToDate($dados->dt_venc_boleto);
                        $this->parcela_boleto->data_vencimento_origem = DataHelper::setDateTimeToDate($dados->dt_base);
                        $this->parcela_boleto->percentualmulta = $this->configuracao_receita->percentualmulta;//2.8
                        $this->parcela_boleto->percentualjuros = $this->configuracao_receita->percentualmulta;//1.14
                        $this->parcela_boleto->juros_apos = 1;
                        $this->parcela_boleto->dias_protesto = false;
                        $this->parcela_boleto->nosso_numero = $dados->nosso_numero;
                        $this->parcela_boleto->numero_documento = $dados->agrp_boleto;
                        //Verifica se boleto foi recebido
                        if ($dados->dt_cancelamento != '') {
                            $this->parcela_boleto->situacao = "Cancelado";
                        } elseif ($dados->dt_pagamento != '') {
                            $this->parcela_boleto->situacao = "Compensado";
                            $this->recebimento_parcela->valor_recebido = DataHelper::getRealToDouble($dados->valor_boleto);
                            $this->recebimento_parcela->data_compensado = DataHelper::setDateTimeToDate($dados->dt_compensacao);
                            $this->recebimento_parcela->data_recebimento = DataHelper::setDateTimeToDate($dados->dt_pagamento);
                            $this->recebimento_parcela->update();
                        } else {
                            $this->parcela_boleto->situacao = "Provisionado";
                        }

                        $this->parcela_boleto->agrupado = 0;
                        $this->parcela_boleto->aceite = 0;//0(zero)
                        $this->parcela_boleto->especie_doc = 'DM';
                        $this->parcela_boleto->save();
                    }
                    $this->check_noss_num = $dados->nosso_numero;
                    $i++;
                }
            });

            \DB::commit();
            $retorno = [
                'msg' => 'Migração efetuada com sucesso!',
                'Imoveis Não encontrados'=> $this->imoveis_n_encontrados,
                'Associados não encontrado'=> $this->pessoas_n_encontrados,
                'qtd_imovel_n_econtrado' => $this->qtd_imovel_n_econtrado,
                'qtd_pessoa_n_econtrada' => $this->qtd_pessoa_n_econtrada
            ];
//        } catch (\Exception $e) {
//            \DB::rollBack();
//            $retorno = $e;
//        } catch ( \ErrorException $err){
//            $retorno = $err;
//            $retorno = $err;
//        }

        echo 'Fim: '.date('H:i:s');
        \Log::info('Fim: '.date('H:i:s'));
        return $retorno;
    }

    public function importCSVAssociadojdsMadri($ano_competencia) {

        set_time_limit(0);

//        $result_parceito_receitaas =  \DB::table('import_receitas')->select(['cod_parceiro'])->limit(5)->get();
//        $import_parceiro = \DB::table('import_parceiro')->whereIn('id',$result_parceito_receitaas)->limit(1)->get();

        $import_parceiro = \DB::table('import_parceiro')->whereIn('id',function($query) use ($ano_competencia) {
            $query->select('cod_parceiro')
                ->from('import_receitas')->groupBy('cod_parceiro');
        })->get();
//        var_dump(count($import_parceiro));
//        exit();

        \DB::beginTransaction();
        $associado_encontrado =0;
        $associado_n_encontrado = 0;
        $associado_incluidos = 0;
        $pessoas[] = null;
        $i=0;
        foreach ($import_parceiro as $dados) {

            $pessoa_cpf = Pessoa::where('cpf', $dados->cpf)->get();
            $pessoa_nome = Pessoa::where('nome', $dados->nome)->get();
/*return  response()->success($pessoa_cpf);*/
            if(!count($pessoa_cpf) || !count($pessoa_nome)) {
                $pessoas[$i] = [
                    'id'=> $dados->id,
                    'associado'=> $dados->associado,
                    'ativo'=> $dados->ativo,
                    'dt_cadastro'=>$dados->dt_cadastro,
                    'fornecedor'=>$dados->fornecedor,
                    'nome'=>$dados->nome,
                    'cpf'=>$dados->cpf,
                    'dt_nascimento'=>$dados->dt_nascimento,
                    'estado_civil'=>$dados->estado_civil,
                    'genero'=>$dados->genero,
                    'rg'=>$dados->rg,
                    'nome_mae'=>$dados->nome_mae,
                    'nome_pai'=>$dados->nome_pai,
                    'cnpj'=>$dados->cnpj,
                    'inscricao_estadual'=> $dados->inscricao_estadual,
                    'inscricao_municipal' => $dados->inscricao_municipal,
                    'razao_social'=>$dados->razao_social,
                    'instituicao'=>$dados->instituicao,
                    'enderecos' =>$dados->enderecos,
                    'emails' => $dados->emails,
                    'telefones' => $dados->telefones
                ];

                $pessoa = new Pessoa();
                $pessoa->nome = $dados->nome;
                $pessoa->cpf = $dados->cpf;
                $pessoa->data_cadastro =  DataHelper::setDateTimeToDate($dados->dt_cadastro);
                $pessoa->mae = $dados->nome_mae;
                $pessoa->pai = $dados->nome_pai;
                $pessoa->tipo = 'm';
                $pessoa->save();
               // $pessoas[$i] = $pessoa;

                $pessoa_permanente = new PessoaPermanente();
                $pessoa_permanente->id_pessoa = $pessoa->id;
                $pessoa_permanente->pai = $dados->nome_pai;
                $pessoa_permanente->ativo = 'n';
                $pessoa_permanente->permitir_acesso_toten = 'n';
                $pessoa_permanente->id_imovel = 1;
                $pessoa_permanente->save();


//                $imovel_permanente = new ImovelPermanente();
//                $pessoa->sexo = '';

//                $pessoa->apresenta_menssagem_entrada = '';
//                $pessoa->mensagem = '';
//                $pessoa->obs_seguranca = '';
//                $pessoa->id_cnh = '';
//                $pessoa->id_usuario_atendente = '';

//                $pessoa->url_foto = '';
//                $pessoa->rg = '';
//                $pessoa->ultima_alteracao = '';
//                $pessoa->tel1 = '';
//                $pessoa->ramal = '';
//                $pessoa->tel2 = '';
//                $pessoa->pessoa_permanente = '';
//                $pessoa->outro_documento = '';
//                $pessoa->tipo_outro_documento = '';
//                $pessoa->orgao_expeditor = '';
//                $pessoa->cel3 = '';
//                $pessoa->cel4 = '';
//                $pessoa->agrupar_titulos = '';
                //$associado_incluidos = $associado_incluidos +1;
                $associado_n_encontrado = $associado_n_encontrado +1;
                $i++;
            } else {
                $associado_encontrado = $associado_encontrado +1;

            }
        }
        \DB::commit();
        $retorno = [
            'Associados Encontradaos' => $associado_encontrado,
            'Associados Não Econtrados' => $associado_n_encontrado,
            'Associados Incluidos'=> $associado_incluidos,
            'Pessoas' => $pessoas
        ];
        return $retorno;

    }

    public function importCSVContasAPagarJdsMadri()
    {
        \Log::info('Início '.date('H:i:s'));
        $id_cpg = 0;
        $import = \DB::table('import_conta_pagar')->get();

        try {
            \DB::beginTransaction();

            foreach ($import as $dados) {
                if ($id_cpg != $dados->agrp_cpg) {
                    $fornecedor = Empresa::where('razao_social', $dados->nome)->orWhere('nome_fantasia',$dados->nome)->first();
                    if (count($fornecedor)) {
                        $id_fornecedor = $fornecedor->id;
                    } else {
                        $empresa = Empresa::create([
                            "data_cadastro" => date("Y-m-d H:i:s"),
                            "razao_social" => $dados->nome,
                            "nome_fantasia" => $dados->nome,
                            "obs" => 'Cadastrado na importação de dados'
                        ]);
                        $id_fornecedor = $empresa->id;
                        \Log::info('Empresa cadastrada->id: '.$empresa->id.' razao_social: '.$dados->nome);
                    }
                    $documento = TipoDocumento::where('nome', $dados->tipo_documento)->first();
                    if (count($documento)) {
                        $id_tipo_documento = $documento->id;
                    } else {
                        $tipo_documento = TipoDocumento::create([
                            "nome" => $dados->tipo_documento
                        ]);
                        $id_tipo_documento = $tipo_documento->id;
                    }
                    $tipo_lancamento = TipoLancamento::find($dados->agrp_tipo_lancamento);
                    //CADASTRANDO O LANÇAMENTO DA DESPESA
                    $lancamento_agendar = new LancamentoAgendar();
                    $lancamento_agendar->descricao = $dados->descricao;
                    $lancamento_agendar->id_tipo_lancamento = $tipo_lancamento->id;
                    $lancamento_agendar->id_fornecedor = $id_fornecedor;
                    $lancamento_agendar->id_tipo_documento = $id_tipo_documento;
                    $lancamento_agendar->mes_competencia = $dados->mes_competencia;
                    $lancamento_agendar->ano_competencia = $dados->ano_competencia;
                    $lancamento_agendar->data_base = DataHelper::setDateTimeToDate($dados->dt_agendamento);
                    $lancamento_agendar->valor = DataHelper::getRealToDouble($dados->valor_total);
                    $lancamento_agendar->id_localizacao = 1;
                    $lancamento_agendar->id_departamento = 3;
                    $lancamento_agendar->save();

                    $id_cpg = $dados->agrp_cpg;
                }
                //CADASTRANDO AS PARCELAS
                $conta_pagar = new ParcelaPagar();
                $conta_pagar->id_lancamento_agendar = $lancamento_agendar->id;
                $conta_pagar->id_conta_bancaria = 2;
                $conta_pagar->data_base = DataHelper::setDateTimeToDate($dados->dt_agendamento);
                $conta_pagar->valor_pago = DataHelper::getRealToDouble($dados->valor_total);
                switch ($dados->situacao) {
                    case 'Em aberto':
                        $operacao = 'Provisão';
                        break;
                    case 'Pago':
                        $operacao = 'Débito';
                        break;
                    default:
                        $operacao = 'Cancelado';
                }
                $conta_pagar->tipo_operacao = $operacao;
                $conta_pagar->forma_pagamento = $dados->forma_pagamento;
                $conta_pagar->forma_pagamento_origem = $dados->forma_pagamento;
                $conta_pagar->data_compensacao = $dados->dt_compensacao ? DataHelper::setDateTimeToDate($dados->dt_compensacao) : '';
                $conta_pagar->data_pagamento = $dados->dt_pagamento ? DataHelper::setDateTimeToDate($dados->dt_pagamento) : '';
                $conta_pagar->save();
            }
            \DB::commit();
            $retorno = 'OK finalizado!';
        } catch (\Exception $e) {
            \DB::rollBack();
            $retorno = $e;
        } catch ( \ErrorException $err){
            $retorno = $err;
            $retorno = $err;
        }
        \Log::info('Hora fim '.date('H:i:s'));
        return $retorno;
    }

    public function importCSVFornecedorHojeDiaADia()
    {
        set_time_limit(0);
        $import_parceiro = \DB::table('import_parceiro')
            ->where('fornecedor', 'true')
            ->get();

        \DB::beginTransaction();

        foreach ($import_parceiro as $dados) {
            Empresa::create([
                'data_cadastro'=> DataHelper::setDateTimeToDate($dados->dt_cadastro),
                'razao_social'=> $dados->razao_social? $dados->razao_social:$dados->nome,
                'nome_fantasia'=> $dados->nome,
                'cnpj' => $dados->cpf ? substr($dados->cpf,0,18) : substr($dados->cnpj,0,18) ,
                'ie' => $dados->cnpj ? substr($dados->inscricao_estadual,0,12): substr($dados ->rg,0,12),
                'email'=> substr($dados->emails,0,50),
                'tel1'=> $dados->telefones,
                'endereco' => substr($dados->enderecos,0,100),
                'tipo'=> $dados->cnpj ? 'j': 'f'
            ]);
        }
        \DB::commit();
        return response("Concluido com sucesso");
    }

    public function importCSVProdutosHojeDiaADia()
    {
        set_time_limit(0);
        $import_parceiro = \DB::table('import_produtos')->get();

        \DB::beginTransaction();

        foreach ($import_parceiro as $dados) {
            Produto::create([
                'idunidade_produto'=>1,
                'idgrupo_produto'=>$this->getGrupoProduto($dados->grupo),
                'descricao'=>$dados->descricao,
                'quantidade_minima'=> 0 ,
                'quantidade_maxima'=>0,
                'quantidade_atual' =>0,
                'origem'=>'0XX – NACIONAL',
                'tipo'=>0,
                'status'=>1
            ]);
        }
        \DB::commit();
        return response("Concluido com sucesso");
    }

    public function getGrupoProduto($descricao)
    {

        $grupo = GrupoProduto::where('descricao',$descricao)->first();
        if(count($grupo)){
            return $grupo->id;
        }

        return 1;
    }

    public function importCSVGrupoProdutoHojeDiaADia()
    {
        set_time_limit(0);
        $import_produtos = \DB::table('import_produtos')->select(['grupo'])
            ->where('grupo','!=','')->groupBy('grupo')->get();

        \DB::beginTransaction();

        foreach ($import_produtos as $dados) {
            $grupo = GrupoProduto::create(['descricao' => $dados->grupo, 'depreciacao' => 0, 'status' => 1]);
        }
        \DB::commit();
        return response("Concluido com sucesso");
    }

    public function correcaoMigracaoReceitasAssociado()
    {
        set_time_limit(0);
        $parcela_boletos = ParcelaBoleto::all();

        foreach ($parcela_boletos as $parcela_boleto){
            $competencia = new \Carbon\Carbon(DataHelper::setDate($parcela_boleto->data_vencimento_origem));
            $mes=  $competencia->month;
            $ano = $competencia->year;
            $import_receita = \DB::table('import_receitas')->where('mes_competencia', $mes)
                ->where('ano_competencia', $ano)
                ->where('nosso_numero', $parcela_boleto->nosso_numero)
                ->groupBy('agrp_boleto')
                ->get();


            \Log::debug($parcela_boleto->parcela->recebimento->associado->nome);
        }

    }

    public function correcaoMigracaoReceitas(){
        set_time_limit(0);
        $result = RecebimentoParcela::join('parcela_boletos','recebimento_parcelas.id','=','parcela_boletos.id_parcela')
            ->join('recebimento_lancamentos','recebimento_lancamentos.id_recebimento','=','recebimento_parcelas.id_recebimento')
            ->join('lancamentos_contas_receber','recebimento_lancamentos.id_lancamento_receber','=','lancamentos_contas_receber.id')
            ->distinct()
            ->select('parcela_boletos.numero_documento')
                ->where('lancamentos_contas_receber.id_conta_receber', '=', 12259)
//            ->where('parcela_boletos.numero_documento', '=', 159387)
            ->get();

        $qtd_boleto_provisionado = 0;
        $qtd_boleto_compensado = 0;
        $i = 0;
        foreach ($result as $item){
            $boletos  = ParcelaBoleto::where('numero_documento', $item->numero_documento)->get();
            foreach ($boletos as $boleto) {
                if ($boleto->situacao == 'Provisionado'){

                    $qtd_boleto_provisionado =  $qtd_boleto_compensado + 1;
                }
                if ($boleto->situacao == 'Compensado'){
                    $qtd_boleto_compensado = $qtd_boleto_compensado + 1;
                }
            }
            \Log::debug($i);
            $i++;
        }

        return $retorno = [
            'Provisionado'=> $qtd_boleto_provisionado,
            'Compensado'=> $qtd_boleto_compensado
        ];

    }
}
