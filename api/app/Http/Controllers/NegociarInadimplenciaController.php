<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Http\Requests\AcordosEfetuadosRequest;
use App\Http\Requests\InadimplenciaRequest;
use App\Models\Acordo;
use App\Models\AcordoParcelasNegociadas;
use App\Models\FluxoCaixa;
use App\Models\Lancamento;
use App\Models\ContasReceber;
use App\Models\Imovel;
use App\Models\ImovelPermanente;
use App\Models\ParcelaCheques;
use App\Models\ParcelaBoleto;
use App\Models\RecebimentoAcordo;
use App\Models\Receita;
use App\Models\Recebimento;
use App\Models\RecebimentoParcela;
use App\Models\ConfiguracaoCarteira;
use App\Models\TipoLancamento;
use App\Services\FluxoCaixaServices;
use Carbon\Carbon;
use PhpParser\Node\Stmt\Switch_;

class NegociarInadimplenciaController extends Controller
{
    public function calculoSelecionados(InadimplenciaRequest $request)
    {
        $dados = $request->all();
        $config_receita = Receita::first();
        //calculo de juros por dia
        $config_juros = $config_receita->percentualjuros;
        $total_dias_mes = 30;
        $calc_juros = (($config_juros/$total_dias_mes)/100);
        $calc_percent_juros = $calc_juros;

        $now = Carbon::now();
        $idtipo_fundo = 0;
        $idtipo_taxa = 0;
        $total_juros = 0;
        $total_multa = 0;
        $total_parcial = 0;
        $total_original = 0;
        $total_taxa = 0;
        $total_fundo = 0;
        $boletos_negociados = [];
        foreach ($dados["selecionados"] as $item) {
            //gardando o id do titulo negociado
            $boletos_negociados[] = $item["id_boleto"];
            $boleto = RecebimentoParcela::where('id','=',$item["id_boleto"])->first();
            $total_original += $boleto->valor;
            $end = Carbon::parse(DataHelper::setDate($item["vencimento"]));
            $dias_atraso = $end->diffInDays($now);
            $valor = $boleto->valor;
            if($config_receita->modalidadejuro == 'Juros Simples'){
                $juros = ($valor * $calc_percent_juros) * $dias_atraso;
            } else { //juros compostos
                $M = $valor * pow((1 + $calc_percent_juros),$dias_atraso);
                $juros = $M - $valor;
            }
            //totalizando o valor com juros e multas para cada boleto
            $calc_multa_percent = ($config_receita->percentualmulta/100);
            $multa = $boleto->valor * $calc_multa_percent;
            $total_com_multa_e_juros = $boleto->valor + $multa + $juros;
            //somando valor de todos boletos
            $total_juros += $juros;
            $total_multa += $multa;
            $total_parcial += $total_com_multa_e_juros;
            //calculando a soma das taxas e fundos de cada titulo selecionado
            $parcela_boleto = ParcelaBoleto::find($dados["selecionados"][0]["id_boleto"]);
            $arr_lancamentos = $parcela_boleto->parcela->recebimento->lancamentos->first()->conta_receber->lancamentos;
            foreach ($arr_lancamentos as $lancamento){
                if($lancamento->categoria == 1){
                    $total_taxa += $lancamento->valor;
                    $idtipo_taxa = $lancamento->idtipo_lancamento;
                }
                if($lancamento->categoria == 2){
                    $total_fundo += $lancamento->valor;
                    $idtipo_fundo = $lancamento->idtipo_lancamento;
                }
            }

        }
        $result["boletos_negociados"] = $boletos_negociados;
        $result["total_divida"] = $total_original;
        $result["total_multas"] = $total_multa;
        $result["total_juros"] = $total_juros;
        $result["total_correcao"] = 0;
        $result["total_parcial"] = $total_parcial;
        $result["total_taxa"] = $total_taxa;
        $result["total_fundo"] = $total_fundo;
        $result["id_plano_multa"] = $config_receita->id_tipolancamentomulta;
        $result["id_plano_juros"] = $config_receita->id_tipolancamentojuros;
        $result["id_plano_correcao"] = $config_receita->id_tipolancamentocorrecao;
        $result["id_plano_taxa"] = $idtipo_taxa;
        $result["id_plano_fundo"] = $idtipo_fundo;

        return response()->success($result);
    }

    public function negociarInadimplencia( InadimplenciaRequest $request)
    {
        try {
            $dados = $request->all();
            $lancamentos_form = $dados["acrescimos"];
            $lancamento_ref = [];
            if(is_array($dados["descontos"])){
                $lancamentos_form = array_merge($lancamentos_form,$dados["descontos"]);
            }

            //buscando lancamentos de taxa e fundo dos boletos_negociados
            $soma_taxa = 0;
            $soma_fundo = 0;
            $soma_desconto = 0;
            $soma_entrada = 0;
            foreach ($dados["boletos_negociados"] as $boleto_negociado) {
                $lanc_bol_negociados = RecebimentoParcela::find($boleto_negociado)->recebimento;
                $lanc_bol_negociados->lancamentos;
                //verifica se as parcelas negociadas são de outro acordo e verifica se tem valor de entrada
                $parcelas_negociadas_acordo = Acordo::where('id_recebimento',$lanc_bol_negociados->id)
                    ->where('status',1)
                    ->select('valor_entrada')
                    ->first();
                if ($parcelas_negociadas_acordo and !is_null($parcelas_negociadas_acordo->valor_entrada)) {
                    $soma_entrada += ($parcelas_negociadas_acordo->valor_entrada / $lanc_bol_negociados->numero_parcelas);
                }
                foreach ($lanc_bol_negociados->lancamentos as $item) {
                    $lanc_ = Lancamento::find($item->id_lancamento);
                    if ($lanc_->categoria == 1) {
                        $soma_taxa += ($lanc_->valor / $lanc_bol_negociados->numero_parcelas);
                    } elseif ($lanc_->categoria == 2) {
                        $soma_fundo += ($lanc_->valor / $lanc_bol_negociados->numero_parcelas);
                    } elseif ($lanc_->categoria == 7) {
                        $soma_desconto += ($lanc_->valor / $lanc_bol_negociados->numero_parcelas);
                    } else $lanc_outros_lanc[] = [
                        'valor' => ($lanc_->valor / $lanc_bol_negociados->numero_parcelas),
                        'idtipo_lancamento' => $lanc_->idtipo_lancamento,
                        'categoria' => 3,
                        'descricao' => $lanc_->descricao.' (lançamento parcelas negociadas)'
                    ];
                }
            }
            // todos lancamentos das parcelas negociadas da categoria taxa são somados e se torna um lançamento de taxa
            if($soma_taxa != 0) {
                $arr_taxa[0] = [
                    'valor' => $soma_taxa,
                    'idtipo_lancamento' => 1,
                    'categoria' => 1,
                    'descricao' => 'Taxa(lançamento parcelas negociadas)'
                ];
                $lancamentos_form = array_merge($lancamentos_form,$arr_taxa);
            }
            // todos lancamentos das parcelas negociadas da categoria fundo são somados e se torna um lançamento de fundo
            if($soma_fundo != 0) {
                $arr_fundo[0] = [
                    'valor' => $soma_fundo,
                    'idtipo_lancamento' => 2,
                    'categoria' => 2,
                    'descricao' => 'Fundo(lançamento parcelas negociadas)'
                ];
                $lancamentos_form = array_merge($lancamentos_form,$arr_fundo);
            }
            //todos lancamentos de descontos das parcelas negociadas serão acumuladas aqui
            if($soma_desconto != 0) {
                $arr_desconto[0] = [
                    'valor' => $soma_desconto,
                    'idtipo_lancamento' => 7,
                    'categoria' => 7,
                    'descricao' => 'DESCONTOS (lançamento parcelas negociadas)'
                ];
                $lancamentos_form = array_merge($lancamentos_form,$arr_desconto);
            }
            if($soma_entrada) {
                $arr_entrada[0] = [
                    'valor' => $soma_entrada,
                    'idtipo_lancamento' => 7,
                    'categoria' => 7,
                    'descricao' => 'ENTRADA (lançamentos parcelas negociadas)'
                ];
                $lancamentos_form = array_merge($lancamentos_form,$arr_entrada);
            }
            // todos os outros lancamentos das parcelas negociadas foram transformadas em categoria de "outros lançamentos"
            // e adicionada ao array dos novos lançamentos de acordo
            if(isset($lanc_outros_lanc)) {
                $lancamentos_form = array_merge($lancamentos_form,$lanc_outros_lanc);
            }

            if($dados["pgto_avista"] > 0) {
                $dados["valor_entrada"] = $dados["pgto_avista"];
            }

            \DB::beginTransaction();

            foreach ($lancamentos_form as $lancamentos) {
                $lancamentos["saldo_receber"] = 0;
                $lancamentos["descricao"] = (!isset($lancamentos["descricao"])) ? TipoLancamento::find($lancamentos["idtipo_lancamento"])->descricao : $lancamentos["descricao"];
                $lancamento_cad = Lancamento::create($lancamentos);
                $lancamento_ref[] = $lancamento_cad->id;
            }
            $conta_receber = new ContasReceber();
            $conta_receber->valor_total = $dados['valor_acordo'];
            $conta_receber->total_provisionado = $dados['valor_acordo'];
            $conta_receber->valor_original = $dados['valor_acordo'];
            $conta_receber->total_recebido = $dados["forma_pagamento"] === 'À Vista' ? $dados['valor_acordo'] : 0;
            $conta_receber->data_agendamento = $dados["parcelas"][0]["data_vencimento"];

            if ($dados["id_imovel"] != "") {
                $conta_receber->id_imovel = $dados['id_imovel'];
            } else {
                $conta_receber->id_empresa = $dados['id_empresa'];
            }
            $conta_receber->save();
            foreach ($lancamento_ref as $lancamento_pivot) {
                $conta_receber->lancamentos()->attach($lancamento_pivot);
            }
            $recebimento = new Recebimento();
            $recebimento->id_configuracao_carteira = $dados["id_config_carteira"];
            $recebimento->id_layout_remessa = $dados["layout"];
            if ($dados["id_imovel"] != "") {
                $recebimento->idimovel = $dados["id_imovel"];
                $recebimento->idassociado = $dados["pessoa_id"];
            } else {
                $recebimento->id_empresa = $dados["id_empresa"];
            }
            $recebimento->data_agendamento = $dados["parcelas"][0]["data_vencimento"];
            $recebimento->numero_parcelas = $dados["qtd_parcelas"];
            $recebimento->save();

            foreach ($conta_receber->lancamentos as $lancamento) {
                $recebimento->lancamentos()->attach($lancamento->pivot->id);
            }

            $configReceita = Receita::all('percentualmulta','percentualjuros','tempoinadimplencia')->first();
            $configCarteira = ConfiguracaoCarteira::find($dados["id_config_carteira"]);
            $quadra = (count(strlen($dados["quadra"])) == 1)?'0'.$dados["quadra"]:$dados["quadra"];
            $lote = (count(strlen($dados["lote"])) == 1)?'0'.$dados["lote"]:$dados["lote"];

            for ($i=0;$i<$dados["qtd_parcelas"];$i++){
                switch ($dados["parcelas"][$i]["forma_pagamento"]) {
                    case 'À Vista':
                        $forma_pagamento = 'DINHEIRO';
                        break;
                    case 'Cheque':
                        $forma_pagamento = 'CHEQUE';
                        break;
                    default:
                        $forma_pagamento = 'TITULO';
                }
                $recebimento_parcela = new RecebimentoParcela();
                $recebimento_parcela->forma_pagamento = $forma_pagamento;
                $recebimento_parcela->valor = $dados["parcelas"][$i]["valor_parcela"];
                $recebimento_parcela->valor_origem = $dados["parcelas"][$i]["valor_parcela"];
                $recebimento_parcela->valor_recebido = $dados["parcelas"][$i]["forma_pagamento"] === 'À Vista' ? $dados["parcelas"][$i]["valor_parcela"] : 0;
                $recebimento_parcela->id_recebimento = $recebimento->id;
                $recebimento_parcela->id_situacao_inadimplencia = 1;
                if ($dados["parcelas"][$i]["forma_pagamento"] === 'À Vista') {
                    $recebimento_parcela->data_compensado = $dados["parcelas"][$i]["data_vencimento"];
                    $recebimento_parcela->data_recebimento = $dados["parcelas"][$i]["data_vencimento"];
                }
                $recebimento_parcela->save();

                /*$dados["forma_pagamento"] = strtoupper($dados["forma_pagamento"]);
                if ($dados["forma_pagamento"] == 'TITULO'){*/

                $titulo = new ParcelaBoleto();
                $titulo->id_parcela = $recebimento_parcela->id;
                $titulo->data_vencimento = $dados["parcelas"][$i]['data_vencimento'];
                $titulo->data_vencimento_origem = $dados["parcelas"][$i]['data_vencimento'];
                $titulo->percentualmulta = $configReceita->percentualmulta;
                $titulo->percentualjuros = $configReceita->percentualjuros;
                $titulo->juros_apos = $configReceita->tempoinadimplencia;
                $titulo->dias_protesto = false;
                $titulo->nosso_numero = $configCarteira->nosso_numero_inicio;
                $titulo->nosso_numero_origem = $configCarteira->nosso_numero_inicio;
                $titulo->numero_documento = $dados["parcelas"][$i]['numero_documento'] ? $dados["parcelas"][$i]['numero_documento'] : $recebimento_parcela->id;
                $titulo->numero_controler = $dados["pessoa_id"].'QD'.$quadra.'LT'.$lote;
                $titulo->situacao = $dados["parcelas"][$i]["forma_pagamento"] === 'À Vista' ? 'Compensado' : 'Provisionado';
                $titulo->agrupado = 0;
                $titulo->aceite = 0;
                $titulo->especie_doc = 'DM';
                $titulo->save();
                //atualiza novo nosso_numero
                $configCarteira->nosso_numero_inicio = $configCarteira->nosso_numero_inicio + 1;
                $configCarteira->update();

//                } elseif ($dados["forma_pagamento"] == 'CHEQUE'){
//                    $cheque = new ParcelaCheques();
//                    $cheque->id_parcela = $recebimento_parcela->id;
//                    $cheque->data_vencimento = DataHelper::setDate($dados["parcelas"][$i]['data_vencimento']);
//                    $cheque->data_emissao = DataHelper::setDate($dados["parcelas"][$i]['data_emissao']);
//                    $cheque->data_predatado = DataHelper::setDate($dados["parcelas"][$i]['data_predatado']);
//                    $cheque->codigo_banco = $dados["parcelas"][$i]['codigo_banco'];
//                    $cheque->agencia = $dados["parcelas"][$i]['agencia'];
//                    $cheque->numero_cheque = $dados["parcelas"][$i]['numero_cheque'];
//                    $cheque->save();
//                }

                //Cria fluxo para as parcelas geradas
                $fluxo = [
                    'id_conta_bancaria' => $configCarteira->id_conta_bancaria,
                    'id_parcela' => $recebimento_parcela->id,
                    'valor' => $dados["parcelas"][$i]["valor_parcela"],
                    'data_vencimento' => $dados["parcelas"][$i]['data_vencimento'],
                    'data_pagamento' => null,
                    'fluxo' => 'RECEITA',
                    'tabela' => 'recebimento_parcela',
                    'descricao' => 'Nº Doc '.(isset($titulo->nosso_numero) ? $titulo->nosso_numero : $dados["parcelas"][$i]['numero_documento']).' - Título acordo inadimplência',
                    'referente' => $recebimento->associado->nome
                ];
                FluxoCaixaServices::createFluxo($fluxo);
            }

            //grava dados do acordo
            $acordo = new Acordo();
            switch ($dados["forma_pagamento"]) {
                case 'À Vista':
                    $forma_pagamento_acordo = 'DINHEIRO';
                    break;
                case 'Cheque':
                    $forma_pagamento_acordo = 'CHEQUE';
                    break;
                default:
                    $forma_pagamento_acordo = 'TITULO';
            }
            if (!$dados["id_imovel"] == "") {
                $acordo->id_associado = $recebimento->idassociado;
                $acordo->id_imovel = $dados['id_imovel'];
            } else {
                $acordo->id_empresa = $recebimento->id_empresa;
            }
            $acordo->id_recebimento = $recebimento->id;
            $acordo->nome_parceiro = $dados["nome_parceiro"];
            $acordo->forma_pagamento = $forma_pagamento_acordo;
            $acordo->data_acordo = date('d/m/Y');
            $acordo->data_agendamento = $dados["parcelas"][0]["data_vencimento"];
            $acordo->valor_divida = $dados["valor_divida"];
            $acordo->valor_acordo = $dados["valor_acordo"];
            $acordo->valor_entrada = $dados["forma_pagamento"] === 'À Vista' ? null : ($dados["valor_entrada"] != "") ? $dados["valor_entrada"] : null;
            $acordo->data_recebimento_entrada = ($dados["data_recebimento_entrada"] != "") ? DataHelper::setDate($dados["data_recebimento_entrada"]) : NULL;
            $acordo->comprovante_entrada = ($dados["comprovante_entrada"] != "") ? $dados["comprovante_entrada"] : null;
            $acordo->status = 1;
            $acordo->save();

            $parcelas_negociadas = $dados["boletos_negociados"];
            //muda o status dos boletos negociados
            ParcelaBoleto::whereIn('id_parcela',$parcelas_negociadas)->update(['situacao' => 'Negociado']);
            //relaciona o recebimento gerado  do acordo com o as parcelas negociadas
            foreach ($parcelas_negociadas as $id) {
                FluxoCaixa::where('id_parcela',$id)->where('tabela','recebimento_parcela')->delete();
                $acordo_negociadas = new AcordoParcelasNegociadas();
                $acordo_negociadas->id_acordo = $acordo->id;
                $acordo_negociadas->id_parcela_negociada = $id;
                $acordo_negociadas->save();

            }

            \DB::commit();
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        } catch (QueryException $q ) {
            \DB::rollBack();
            return response()->error('Problemas ao gravar registro!<>'.$q->getMessage());
        }
         return response()->success('Negociação gerada com sucesso!');
    }

}
