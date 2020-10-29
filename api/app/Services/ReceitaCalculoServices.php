<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 19/01/17
 * Time: 17:51
 */

namespace App\Services;

use App\EnumCategoriaLancamento;
use App\Helpers\DataHelper;
use App\Models\Estimado;
use App\Models\LogProcesso;
use App\Models\ConfiguracaoCarteira;
use App\Models\Lancamento;
use App\Models\LancamentoFundo;
use App\Models\LancamentoRecorrente;
use App\Models\Condominio;
use App\Models\CondominioConfiguracoes;
use App\Models\ContaBancaria;
use App\Models\ContasReceber;
use App\Models\GrupoCalculo;
use App\Models\GrupoCalculoImovel;
use App\Models\Imovel;
use App\Models\ImovelPermanente;
use App\Models\LancamentosEstimados;
use App\Models\LancamentoTaxa;
use App\Models\ParcelaBoleto;
use App\Models\PreLancamento;
use App\Models\Recebimento;
use App\Models\RecebimentoParcela;
use App\Models\Receita;
use App\Models\ReceitaCalculo;
use Illuminate\Database\QueryException;
use League\Flysystem\Exception;
use Psy\Exception\ErrorException;
use Respect\Validation\Rules\Date;
use Symfony\Component\Debug\Exception\FatalErrorException;

class ReceitaCalculoServices {
//    const DESPESA_TOTAL = 125.0;
//    const AREA_TOTAL = 1.0;
//    const AREA_IMOVEL =25.0;

    public function getInfoCalculo($mes,$ano)
    {
            //Busca parâmetros de configuração do condomínio
            $condominioconfiguracoes = CondominioConfiguracoes::all('tipodeapuracao','diavencimento')->first();
            if(!count($condominioconfiguracoes)){
                return ("Nenhuma configuração do condomínio cadastrada!");
            }

            //Busca o total de imovel ativo não fícticio
            $total_imoveis = Imovel::getTotalImovelAtivoNaoFicticio();

            //Busca parâmetros de configuração de Receita
            $receita = Receita::all('percentualmulta', 'percentualjuros', 'id_configuracao_carteira')->first();
            if(!count($receita)){
                return("Nenhuma configuração de receita cadastrada!");
            }

            //Busca dados da conta bancaria(carteira)
            $contabancaria = ContaBancaria::join('bancos','conta_bancarias.idbanco', '=', 'bancos.id')
                ->join('configuracao_carteiras','conta_bancarias.id', '=', 'configuracao_carteiras.id_conta_bancaria')
                ->join('carteiras','configuracao_carteiras.id_carteira', '=', 'carteiras.id')
                ->join('receitas','conta_bancarias.id', '=', 'receitas.id_configuracao_carteira','left')
                ->select('configuracao_carteiras.id','bancos.codigo', 'bancos.descricao as banco', 'conta_bancarias.conta','carteiras.descricao as carteira','carteiras.id as id_carteira')
                ->where('configuracao_carteiras.id','=',$receita->first()->id_configuracao_carteira)
                ->get() ;

            if(!count($contabancaria)){
                return("Nenhuma conta bancaria configurada!");
            }

            //Busca percentual do fundo de reserva
            $grupo_calculo = GrupoCalculo::all('percentualfundoreserva');
            if(!count($grupo_calculo)){
                return("Nenhum percentual de fundo de reserva cadastrado!");
            }
            //Busca área total do condomínio
            $areatotal_condominio = Imovel::getAreaTotalCondominio();
//            $areatotal_condominio = Condominio::all('area_total');
            //Busca total de despesa conforme o tipo de apuracação.
            if ($areatotal_condominio > 0) {
                $despesa_total = $this->calculaDespesaTotal($condominioconfiguracoes->tipodeapuracao, $mes, $ano);
                //calcula a fração ideial de rateio
                $fracao_ideal = $this->calculafracaoIdeal($despesa_total, $areatotal_condominio);
            } else {
                $despesa_total = 0;
                $fracao_ideal = 0;
            }
            //data de vencimento
            if (!is_null($mes)){
                $dia_venc = $condominioconfiguracoes->diavencimento;
                $data_vencimento = $dia_venc.'/'.$mes.'/'.$ano;
            } else {
                $data_vencimento = $condominioconfiguracoes->gerarDataDevencimento();
            }
            //Prepara as informações para retorno
            $data = [
                'despesa_total'=> $despesa_total,
                'area_total'=> $areatotal_condominio,
                'total_imoveis'=>$total_imoveis,
                'fracao_ideal'=> $fracao_ideal,
                'tipo_apuracao'=> $condominioconfiguracoes->tipodeapuracao,
                'data_vencimento'=> $data_vencimento,
                'percentual_juros'=> $receita->first()->percentualjuros,
                'percentual_multa'=> $receita->first()->percentualmulta,
                'percentual_fundo_reserva'=> $grupo_calculo->first()->percentualfundoreserva,
                'carteira'=>  $contabancaria->first()->codigo. '-' . $contabancaria->first()->banco.' '. $contabancaria->first()->conta . ' ' . $contabancaria->first()->carteira
            ];

            return $data;
    }

    private function calculaDespesaTotal($tipodeapuracao,$mes = null, $ano = null)
    {
        $total = [];
        //Verifica o tipo de apuração definida
        if($tipodeapuracao == "Despesa Estimada") {
            //valor das despesas com fundo
            $total["despesas_com_fundo"] = Estimado::where('mes_competencia',$mes)->where('ano_competencia',$ano)->where('fundo_reserva',1)->sum('valor');
            //valor das despesas sem fundo
            $total["despesas_sem_fundo"] = Estimado::where('mes_competencia',$mes)->where('ano_competencia',$ano)->where('fundo_reserva',0)->sum('valor');
            $grupo_calculo = GrupoCalculo::all('percentualfundoreserva');
            $percentual_fundo_reserva = $grupo_calculo->first()->percentualfundoreserva;
            $total["fundo_reserva"] = ($total["despesas_com_fundo"] * $percentual_fundo_reserva)/100;
            //valor total
            $total["total_estimado"] = (double)($total["despesas_sem_fundo"] + $total["despesas_com_fundo"]);
            $total["total_estimado_com_fundo"] = (double)($total["total_estimado"] + $total["fundo_reserva"]);
            return $total;
        } else {
            //TODO: Calcular valor total da despesa quando tipo de apuração for 'Despesa Realizada'
            return $total;
        }
    }

    private function calculafracaoIdeal($despesa,$areatotal_condominio)
    {
        $fracao = [];
        $fracao["valor_rateio_m2"] = $despesa["total_estimado"]/$areatotal_condominio;
        $fracao["valor_rateio_fundo"] = $despesa["fundo_reserva"]/$areatotal_condominio;
        return $fracao;
    }

    public function simularCalculo($infor)
    {
        //verfica se o calculo já foi feito para o mes selecionado
        $mes_ano = explode('/',$infor["data_vencimento"]);
        $mes = $mes_ano[1];
        $ano = $mes_ano[2];
        $calculo_feito = ReceitaCalculo::whereRaw('month(data_vencimento) = '.$mes)->whereRaw('year(data_vencimento) = '.$ano)->get();
        if($calculo_feito->count() > 0) {
            throw  new Exception("Já existe uma simulação para o mês selecionado! Recarregue a página por favor.");
        }
        //imoveis sem titular registrado
        $imovel_sem_titular = Imovel::whereRaw("imovel.id not in( select id_imovel from imovel_permanente where excluido = 'n' and pessoa_titular=1)")
            ->where('imovel_ficticio','!=',1)
            ->get();
        //verfica se existe processo em andamento
        $log_processo = LogProcesso::where('data_fim_processo','=',null)->get();

        if(!count($log_processo)) {
            //Busca imoveis e seus associados titulares
            $associados = ImovelPermanente
                ::join('imovel', 'imovel_permanente.id_imovel', '=', 'imovel.id')
                ->join('pessoa', 'imovel_permanente.id_pessoa', '=', 'pessoa.id')
                ->select('imovel.quadra', 'imovel.lote','pessoa.id as pessoa_id', 'pessoa.nome', 'pessoa.cpf','pessoa.orgao_expeditor','pessoa.outro_documento','imovel.base_calculo as area_imovel', 'id_imovel')
                ->where('imovel_permanente.excluido', '=', 'n')
                ->where('imovel.imovel_ficticio', '=', '0')
                ->where('imovel_permanente.pessoa_titular', '=', '1')
                ->orderBy('imovel.quadra', 'ASC')
                ->orderBy('imovel.lote', 'ASC')
                ->get();

            $formulas_aplicadas = [];
            $total_geral = 0;
            $total_pre = 0;
            $total_recorrente = 0;
            $total_outros = 0;
            $rateio = 0;
            $cpf_cnpj_invalido = [];
            $imovel_sem_base_calculo = [];

            //Percorre todos os associados realizando o calculo da taxa de condominio
            foreach ($associados as $key => $associado) {
                $checkCNPJ = DataHelper::validaCNPJ($associado["cpf"]);
                $checkCPF = DataHelper::validaCPF($associado["cpf"]);
                if ($checkCPF || $checkCNPJ) {
                    if (!is_null($associado->area_imovel)) {
                        $result = $this->calcularTaxaAssociativa($infor, $associado);
                        $associado = array_add($associado, 'valor_taxa', $result['valor_taxa']);
                        $associado = array_add($associado, 'formula_aplicada', $result['formula']);
                        $fundo = $this->calcularFundoDeReserva($associado->area_imovel, $infor);
                        $associado = array_add($associado, 'fundo_reserva', $fundo);
                        $associado = array_add($associado, 'id_tipolancamento_taxa', $result['id_tipolancamento_taxa']);
                        $associado = array_add($associado, 'id_tipolancamento_fundo', $result['id_tipolancamento_fundo']);
                        //verfica se tem lancamento recorrente
                        $periodo = DataHelper::setDate($infor["data_vencimento"]);
                        $lancamentos_recor = LancamentoRecorrente::with('lancamento')
                            ->whereRaw("'" . $periodo . "'" . " >= data_ini")
                            ->where('data_fim', '>=', $periodo)
                            ->orWhere('fixo', '>', 0)
                            ->get();

                        if (count($lancamentos_recor)) {
                            foreach ($lancamentos_recor as $item) {
                                if ((boolean)$item->rateio) {
                                    $rateio = $item->lancamento->valor / count($associados);
                                } else {
                                    $rateio = $item->lancamento->valor;
                                }
                                $total_recorrente += $rateio;
                            }
                        }
                        //verifica se tem pre-lancamento
                        $lancamentos_pre = PreLancamento::complete()->where('mes', $mes)->where('ano', $ano)->where('idimovel', $associado->id_imovel);
                        if (count($lancamentos_pre)) {
                            foreach ($lancamentos_pre as $item) {
                                $valor_lancamento = $item->lancamento->valor;
                                if($item->valor_percentual) {
                                    $valor_lancamento = (($result['valor_taxa'] + $fundo)/100 * $item->lancamento->valor);
                                }
                                if (EnumCategoriaLancamento::toString($item->lancamento->categoria) == 'Descontos') {
                                    $total_pre -= $valor_lancamento;
                                } else {
                                    $total_pre += $valor_lancamento;
                                }
                            }
                        }
                        $associado = array_add($associado, 'outros', ($total_pre + $total_recorrente));
                        $associado = array_add($associado, 'taxa_associativa', ($total_pre + $total_recorrente) + ($result['valor_taxa'] + $fundo));
                        $total_geral += (double)(($total_pre + $total_recorrente) + ($result['valor_taxa'] + $fundo));
                        $total_outros += ($total_pre + $total_recorrente);
                        $total_pre = 0;
                        $total_recorrente = 0;
                    }else {
                        $imovel_sem_base_calculo[]["base_calculo"] = $associado["nome"].' - Quadra: '.$associado["quadra"].' Lote: '.$associado["lote"];
                    }
                }

                if (!$checkCPF && !$checkCNPJ) {
                    $cpf_cnpj_invalido[]["nome"] = $associado["nome"];
                    unset($associados[$key]);
                }
            }
            /*$area_imoveis_conflito = \DB::table('condominio')
                ->selectRaw('area_total as area_configurada, (select sum(area_imovel) from imovel where imovel_ficticio != 1) as area_somada')
                ->first();*/

            //Prepara retorno da simulação
            $data = [
                'data_calculo' => date("d/m/Y"),
                'data_vencimento' => $infor["data_vencimento"],
                'despesa_estimada' => $infor["despesa_total"]["total_estimado"],
                'fundo_reserva' => $infor["despesa_total"]["fundo_reserva"],
                'formula_aplicada' => $formulas_aplicadas,
                'informativo',
                'lancamentos' => $associados,
                'lancamentos_json' => json_encode($associados),
                'imovel_sem_titular' => $imovel_sem_titular,
                'imovel_sem_base_calculo' => $imovel_sem_base_calculo,
//                'area_imoveis_conflito' => $area_imoveis_conflito,
                'cpf_cnpj_invalido' => $cpf_cnpj_invalido,
                'total_geral'=>$total_geral,
                'total_outros'=>$total_outros
            ];
            return $data;
        } else {
            throw  new Exception('Existe um processo de cálculo em andamento.');
        }
    }

    private function calcularTaxaAssociativa($infor,$associado)
    {
        $formula = null;
        $valor = 0;
        //Verifica o tipo de apuração para o calculo
        if($infor["tipo_apuracao"]=="Despesa Estimada") {
            //Busca a formula vinculada ao imovel do associado

/*            $formula = GrupoCalculoImovel::
                join('grupo_calculo', 'grupo_calculo_imoveis.id_grupo_calculo', '=', 'grupo_calculo.id')
                ->join('formulas', 'grupo_calculo.id_formula', '=', 'formulas.id')
                ->select('formula','id_tipolancamento_taxaassociativa','id_tipolancamento_fundoreserva')
                ->where('grupo_calculo_imoveis.id_imovel', '=', $associado->id_imovel)->get();*/

            $formula = GrupoCalculo::join('formulas', 'grupo_calculo.id_formula', '=', 'formulas.id')
                ->select('formula','id_tipolancamento_taxaassociativa','id_tipolancamento_fundoreserva')
                ->get();

            if($formula) {
                //Indentifica a formula vinculada ao imovel para realizar o calculo
                switch ($formula->first()->formula) {
                    case 'DESPESA_TOTAL/AREA_TOTAL*AREA_IMOVEL':
                        //Realiza o calculo da taxa
                        $valor = ($infor['fracao_ideal']['valor_rateio_m2'] * $associado->area_imovel);
                        break;
                    default:
                        break;
                }
            }
        } else {
            //TODO: Calcular valor taxa quando tipo de apuração for 'Despesa Realizada'
        }

        //Prepara o Retorno
        $result = [
            'valor_taxa'=> $valor,
            'formula'=>$formula->first()->formula,
            'id_tipolancamento_taxa' => $formula->first()->id_tipolancamento_taxaassociativa,
            'id_tipolancamento_fundo' => $formula->first()->id_tipolancamento_fundoreserva
        ];
        return $result;
    }

    private  function  calcularFundoDeReserva($area_imovel, $infor)
    {
        $fundo_reserva = $infor['fracao_ideal']['valor_rateio_fundo'] * $area_imovel;
        return $fundo_reserva;
    }

    public function aprovarSimulacao($data)
    {
		set_time_limit(0);
        //verfica se existe processo em andamento
        $log_processo = LogProcesso::where('data_fim_processo','=',null)->get();
        if ($log_processo->count() > 0){
            throw new Exception('Existe um processo de cálculo em andamento. Recarregue a página e tente novamente.');
        }
        $receita_parametros = Receita::all('id_configuracao_carteira', 'percentualmulta', 'percentualjuros','id_tipoinadimplenciapadrao')->first()->get();
        if (!count($receita_parametros)) {
            throw new Exception('Carteira não definida nas configurações de Receita.');
        }
        $carteira = ConfiguracaoCarteira::find($receita_parametros->first()->id_configuracao_carteira);

        if (!count($carteira)) {
            throw new Exception('Carteira inválida!');
        }
        try {
            $mes_ano = explode('/',$data["data_vencimento"]);
            $mes = $mes_ano[1];
            $ano = $mes_ano[2];
            $log_processo = LogProcesso::create(["data_inicio_processo"=>date("Y/m/d H:i:s")]);
            \DB::beginTransaction();
            //Registra o calculo realizado
            $calculo = new ReceitaCalculo();
            $calculo->data_calculo = $data['data_calculo'];
            $calculo->data_vencimento = $data['data_vencimento'];
            $calculo->total_despesas_apurada = $data['despesa_total'];
            $calculo->area_total_apurada = $data['area_total'];
            $calculo->total_imoveis = $data['total_imoveis'];
            $calculo->fracao_ideal_rateio = $data['fracao_ideal'];
            $calculo->tipo_apuracao = $data['tipo_apuracao'];
            $calculo->percentual_juros = $data['percentual_fundo_reserva'];
            $calculo->percentual_multa = $data['percentual_multa'];
            $calculo->percentual_fundo_reserva = $data['percentual_fundo_reserva'];
            $calculo->termo_aprovacao = $data['termo_aprovacao'];
            $calculo->save();

            //Registra taxa e fundo calculado e gera uma receita
            $i = 0;
//            error_log(count($data['lancamentos']));
//            die();
            $lancamentos_simulacao =  json_decode($data["lancamentos"]);
            foreach ($lancamentos_simulacao as $item) {
                $associado = ImovelPermanente::getTitularImovel($item->id_imovel);
                if (count($associado)) {
                    $valor_total = 0;
                    $lancamentos = array();
                    //Registra Lancamento
                    error_log($i);
                    error_log($item->id_tipolancamento_taxa);
                    error_log($item->valor_taxa);
                    error_log('______________________________');
                    $i = $i + 1;
                    $lancamento_taxa = Lancamento::create([
                        'idtipo_lancamento' => $item->id_tipolancamento_taxa,
                        'descricao' => 'Taxa de Manutenção m2',
                        'valor' => $item->valor_taxa,
                        'saldo_receber' => 0,
                        'categoria' =>EnumCategoriaLancamento::toOrdinal('Taxa')
                    ]);
                    $lancamentos = array_add($lancamentos, 'id_lancamento_taxa', $lancamento_taxa->id);
                    $valor_total = (double)$lancamento_taxa->valor;

                    //Registra a taxa calculada
                    $taxa = LancamentoTaxa::create([
                        'id_receita_calculos' => $calculo->id,
                        'id_lancamento' => $lancamento_taxa->id,
                        'id_imovel' => $item->id_imovel
                    ]);

                    $lancamento_fundo = Lancamento::create([
                        'idtipo_lancamento' => $item->id_tipolancamento_fundo,
                        'saldo_receber' => 0,
                        'descricao' => 'Fundo de Reserva',
                        'valor' => $item->fundo_reserva,
                        'categoria' =>EnumCategoriaLancamento::toOrdinal('Fundo')
                    ]);
                    $lancamentos = array_add($lancamentos, 'id_lancamento_fundo', $lancamento_fundo->id);
                    $valor_total = $valor_total + (double)$lancamento_fundo->valor;


                    //Registra o fundo de reserva calculado
                    $fundo = LancamentoFundo::create([
                        'id_receita_calculos' => $calculo->id,
                        'id_lancamento' => $lancamento_fundo->id,
                        'id_imovel' => $item->id_imovel
                    ]);


                    //Buscar Lancamento Recorrente
                    $lancamento_recorrentes = LancamentoRecorrente::with('lancamento')
                        ->whereRaw("'".DataHelper::setDate($data["data_vencimento"])."' >= data_ini")
                        ->where('data_fim','>=',DataHelper::setDate($data['data_vencimento']))
                        ->orWhere('fixo','>',0)
                        ->get();

                    if (count($lancamento_recorrentes)) {
                        $i = 0;
                        foreach ($lancamento_recorrentes as $lancamento_recorrente) {
                            if((boolean)$lancamento_recorrente->rateio) {
                                $valor_rateio = $lancamento_recorrente->lancamento->valor/$data['total_imoveis'];
                                $lancamento = Lancamento::create(["valor"=>$valor_rateio,
                                    "saldo_receber"=>$lancamento_recorrente->lancamento->valor,
                                    "idtipo_lancamento"=>$lancamento_recorrente->lancamento->idtipo_lancamento,
                                    "descricao"=>$lancamento_recorrente->lancamento->descricao,
                                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Outros')]);
                                $valor_total = $valor_total + $valor_rateio;
                            } else {
                                $lancamento = Lancamento::create(["valor"=>$lancamento_recorrente->lancamento->valor,
                                    "saldo_receber"=>$lancamento_recorrente->lancamento->valor,
                                    "idtipo_lancamento"=>$lancamento_recorrente->lancamento->idtipo_lancamento,
                                    "descricao"=>$lancamento_recorrente->lancamento->descricao,
                                    'categoria' =>EnumCategoriaLancamento::toOrdinal('Outros')]);
                                $valor_total = $valor_total + (double)$lancamento_recorrente->lancamento->valor;
                            }
                            $lancamentos = array_add($lancamentos, "id_recorrente_$i", $lancamento->id);
                            $i++;
                        }
                    }


                    /**
                     * Vinculando os pré lançamentos
                     * É preciso buscar todos os pré lancamentos cadastrados para o associado e vincular na geração da taxa associativa.
                     * O vinculo com os pré lancamentos tem que ser os utimos valores a serem agregados na gereção da taxa associativa pois é possivel
                     * que um pré lançamento seja um desconto.
                     **/
                    //Inicio do vinculo dos pré lançamentos
                    $lancamentos_pre = PreLancamento::complete()->where('mes',$mes)->where('ano',$ano)->where('idimovel',$item->id_imovel);

                    if (count($lancamentos_pre)) {
                        $i = 0;
                        foreach ($lancamentos_pre as $pre_lancamento) {
                            //Vincula os pré lancamentos nos lançamentos da taxa associativa
                            $lancamentos = array_add($lancamentos, "id_pre_lancamento_$i", $pre_lancamento->lancamento->id);

                            $valor_pre_lancamento = $pre_lancamento->lancamento->valor;
                            if($pre_lancamento->valor_percentual) {
                                $valor_pre_lancamento = ((($lancamento_taxa->valor + $lancamento_fundo->valor)/100) * $pre_lancamento->lancamento->valor);
                            }

                            // Se o pré lançamento for um desconto
                            if(EnumCategoriaLancamento::toString($pre_lancamento->lancamento->categoria)=='Descontos') {
                                //Caso o valor total seja menor que o desconto
                                if($valor_total < (double) $valor_pre_lancamento) {
                                    $valor_credito = (double) $valor_pre_lancamento - $valor_total;
                                    $valor_desconto = $valor_pre_lancamento - $valor_credito;
                                    $valor_total = $valor_total-$valor_desconto;
                                    $pre_lancamento->lancamento->update([
                                        'valor' => $valor_desconto
                                    ]);
                                    //Criar um novo lançãmento com o valor restante
                                    $lancamento = Lancamento::create([
                                        "valor"=>$valor_credito,
                                        "saldo_receber"=>$valor_credito,
                                        "idtipo_lancamento"=>$pre_lancamento->lancamento->idtipo_lancamento,
                                        "descricao"=>$pre_lancamento->lancamento->descricao,
                                        'categoria' =>EnumCategoriaLancamento::toOrdinal('Descontos')
                                    ]);
                                    $Data = PreLancamento::create([
                                        'id_lancamento' => $lancamento->id,
                                        'idimovel' => $pre_lancamento->idimovel,
                                        'observacao' => $pre_lancamento->observacao . "/*** Diferença sobre o desconto anterior aplicado. ID:$pre_lancamento->id **/"
                                    ]);
                                } else {
                                    $valor_total = $valor_total - (double)$valor_pre_lancamento;
                                }

                            } else {
                                $valor_total = $valor_total + (double)$valor_pre_lancamento;
                            }
                            $pre_lancamento->deleted_at = date("Y-m-d");
                            $pre_lancamento->update();
                            $i++;
                        }
                    }
                    //Fim do vinculo dos pré lançamentos

                    //Registra uma conta receber
                    $conta_receber = new ContasReceber();
                    $conta_receber->valor_total = $valor_total;
                    $conta_receber->valor_original = $valor_total;
                    $conta_receber->total_provisionado = $valor_total;
                    $conta_receber->data_agendamento = $data['data_vencimento'];
                    $conta_receber->id_imovel = $item->id_imovel;
                    $conta_receber->save();


                    foreach ($lancamentos as $x => $value) {
                        $conta_receber->lancamentos()->attach($value);
                    }

                    $recebimento = Recebimento::create([
                        'id_configuracao_carteira' => $carteira->id,
                        'id_layout_remessa' => $carteira->id_layout_remessa,
                        'idimovel' => $item->id_imovel,
                        'idassociado' => $associado->first()->id_pessoa,
                        'data_agendamento' => $data['data_vencimento'],
                        'numero_parcelas' => 1
                    ]);

                    foreach ($conta_receber->lancamentos as $lancamento) {
                        $recebimento->lancamentos()->attach($lancamento->pivot->id);
                    }

                    $boleto_zerado = (int)$item->taxa_associativa === 0 ? true : false;

                    $recebimento_parcela = RecebimentoParcela::create([
                        'valor' => $conta_receber->valor_total,
                        'valor_origem'=> $conta_receber->valor_total,
                        'id_recebimento' => $recebimento->id,
                        'forma_pagamento' => 'TITULO',
                        'id_situacao_inadimplencia'=> $receita_parametros->first()->id_tipoinadimplenciapadrao,
                        'data_compensado' => $boleto_zerado ? date('Y-m-d') : null,
                        'data_recebimento' => $boleto_zerado ? date('Y-m-d') : null,
                    ]);

                    $titulo = ParcelaBoleto::create([
                        'id_parcela' => $recebimento_parcela->id,
                        'data_vencimento' => $data['data_vencimento'],
                        'data_vencimento_origem' => $data['data_vencimento'],
                        'percentualmulta' => $receita_parametros->first()->percentualmulta,
                        'percentualjuros' => $receita_parametros->first()->percentualjuros,
                        'juros_apos' => 1,
                        'dias_protesto' => false,
                        'nosso_numero' => $carteira->nosso_numero_inicio,
                        'nosso_numero_origem' => $carteira->nosso_numero_inicio,
                        'numero_documento' =>  $recebimento->id,
                        'numero_controler' => $associado->first()->id_pessoa.'QD'.$item->quadra.'LT'.$item->lote,
                        'situacao' => $boleto_zerado ? 'Compensado' : 'Provisionado',
                        'agrupado' => 0,
                        'aceite' => 0,
                        'especie_doc' => 'DM'
                    ]);

                    $carteira->nosso_numero_inicio = $carteira->nosso_numero_inicio + 1;
                    $carteira->update();

                    //Cria fluxo de caixa para as contas a receber geradas
                    $fluxo = [
                        'id_conta_bancaria' => $carteira->id_conta_bancaria,
                        'id_parcela' => $recebimento_parcela->id,
                        'valor' => $conta_receber->valor_total,
                        'data_vencimento' => $data['data_vencimento'],
                        'data_pagamento' => $boleto_zerado ? date('Y-m-d') : null,
                        'fluxo' => 'RECEITA',
                        'tabela' => 'recebimento_parcela',
                        'descricao' => 'Boleto '.$titulo->nosso_numero.' - Condominio',
                        'referente' => $recebimento->associado->nome
                    ];
                    FluxoCaixaServices::createFluxo($fluxo);
                }
            }
            $log_processo->data_fim_processo = date("Y/m/d H:i:s");
            $log_processo->update();
            \DB::commit();
            set_time_limit(30);
            return 'Aprovação de receita concluída com sucesso!';
        } catch (Exception $e){
            \DB::rollBack();
            \Log::error($e->getTraceAsString());
            throw  new Exception('Problemas na aprovação!');
        } catch (FatalErrorException $f) {
            \DB::rollBack();
            \Log::error($f->getTraceAsString());
             throw  new Exception('Problemas na aprovação!');
        } catch (\ErrorException $errorException) {
            \DB::rollBack();
            \Log::error($errorException->getTraceAsString());
            throw  new Exception('Problemas na aprovação!');
        } catch (QueryException $queryException) {
            \DB::rollBack();
            \Log::error($queryException->getTraceAsString());
            throw  new Exception('Problemas na aprovação!');
        } finally {
            $log_processo->data_fim_processo = date("Y/m/d H:i:s");
            $log_processo->update();
        }

    }
}
