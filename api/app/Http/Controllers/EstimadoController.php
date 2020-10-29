<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Models\Condominio;
use App\Models\Estimado;
use App\Http\Requests\EstimadoRequest;
use App\Models\GrupoCalculo;
use App\Models\Imovel;
use App\PrintPdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use League\Flysystem\Exception;

class EstimadoController extends Controller
{
    private $name = 'Estimados';
    private $arrDados = [];

    public function index(){
        return response()->success(Estimado::complete());
    }

    public function store(EstimadoRequest $request){
        $data = $request->all();
        $estimados = Estimado::where('mes_competencia','=',$data['mes_competencia'])->where('ano_competencia','=',$data['ano_competencia'])->get();
        if(!count($estimados)) {
            try {
                \DB::beginTransaction();

                foreach ($data['lancamentos'] as $lancamento) {
                    $lancamento = array_add($lancamento, 'mes_competencia', $data['mes_competencia']);
                    $lancamento = array_add($lancamento, 'ano_competencia', $data['ano_competencia']);
                    $Data = Estimado::create($lancamento);
                }
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        }
        return response()->error('Mês e ano já aprovado.');
    }

    public function ultimaEstimativa(){
        //verifica se mes atual está aprovado
        $result = Estimado::where('ano_competencia',date('Y'))->where('mes_competencia',date('m'))->first();
        if (count($result) == 0){
            $result["ano_competencia"] = date('Y');
            $result["mes_competencia"] = (int)date('m');
            return $result;
        } else {
            return $this->proximaEstimativa(date('n'));
        }
    }

    public function proximaEstimativa($mes,$ano = null)
    {
        $result = array();
        if (is_null($ano)){
            $ano = date('Y');
        }
        $proximo_mes = date('n',mktime(0,0,0,$mes+1,date('d'),date('Y')));
        $proximo_ano = date('Y',mktime(0,0,0,$mes+1,date('d'),$ano));
        $Data = Estimado::first()->where('ano_competencia',$proximo_ano)->where('mes_competencia',$proximo_mes)->get();
        if ($Data->count() == 0){
            $result["mes_competencia"] = (int)$proximo_mes;
            $result["ano_competencia"] = $proximo_ano;
            return response($result);
        }
         return $this->proximaEstimativa($proximo_mes,$proximo_ano);
    }

    public function listaEstimados(){
        $Data = \DB::table('estimados')
            ->groupBy('mes_competencia')
            ->groupBy('ano_competencia')
            ->orderBy('ano_competencia','ASC')
            ->orderBy('mes_competencia','ASC')
            ->select('id','mes_competencia',\DB::raw("MONTHNAME(concat(ano_competencia,\"-\",mes_competencia,\"-01\")) as mes_extenso"),'ano_competencia')
            ->paginate(13);
        return response($Data);
    }

    public function listaEstimadosSemCalculo(){
        $result = \DB::table('estimados as e')
            ->whereNotExists(function($q){
                $q->select(\DB::raw(1))
                    ->from('receita_calculos as r')
                    ->whereRaw('e.mes_competencia = month(r.data_vencimento)')
                    ->whereRaw('e.ano_competencia = year(r.data_vencimento)');

            })
            ->groupBy('e.mes_competencia')
            ->groupBy('e.ano_competencia')
            ->orderBy('e.ano_competencia','ASC')
            ->orderBy('e.mes_competencia','ASC')
            ->select('e.id','e.mes_competencia',\DB::raw("MONTHNAME(concat(e.ano_competencia,\"-\",e.mes_competencia,\"-01\")) as mes_extenso"),'e.ano_competencia')
            ->get();
        return response()->success($result);
    }

    public function estimadosByData($mes,$ano){
        $result = $this->resumoEstimadosEfetuados($mes,$ano);
        $result["estimados"] = Estimado::complete()->where('mes_competencia',$mes)->where('ano_competencia',$ano);
        return $result;
    }

    public function resumoEstimadosEfetuados($mes,$ano){
        $result = [];
        //Busca percentual do fundo de reserva
        $grupo_calculo = GrupoCalculo::all('percentualfundoreserva');
        if(!count($grupo_calculo)){
            return("Nenhum percentual de fundo de reserva cadastrado!");
        }
        //Busca o total de despesas com fundo de Reserva
        $total_depesas = Estimado::where('mes_competencia',$mes)->where('ano_competencia',$ano)->sum('valor');
        if(!$total_depesas){
            return response()->success($result);
        }
        $total_despesas_sem_fundo = Estimado::where('mes_competencia',$mes)->where('ano_competencia',$ano)->where('fundo_reserva', '=',0)->sum('valor');
        $total_despesas_fundo = Estimado::where('mes_competencia',$mes)->where('ano_competencia',$ano)->where('fundo_reserva', '=',1)->sum('valor');
        $areatotal_condominio = Imovel::getAreaTotalCondominio();
        $percentual_fundo_reserva = $grupo_calculo->first()->percentualfundoreserva;
        $total_fundo_reserva = ($total_despesas_fundo * $percentual_fundo_reserva)/100;
        $valor_rateio_m2 = 0;
        $valor_rateio_fundo = 0;
        if($areatotal_condominio > 0) {
            $valor_rateio_m2 = $total_depesas / $areatotal_condominio;
            $valor_rateio_fundo = $total_fundo_reserva / $areatotal_condominio;
        }
        $total_geral =  $total_depesas + $total_fundo_reserva;

        $result = [
            'total_despesas_com_fundo'=> round($total_despesas_fundo,4),
            'total_fundo_reserva' => round($total_fundo_reserva,4),
            'total_despesas_sem_fundo' => round($total_despesas_sem_fundo,4),
            'total_despesas'=> round($total_depesas,4),
            'valor_rateio_m2'=> round($valor_rateio_m2,4),
            'valor_rateio_fundo'=> round($valor_rateio_fundo,4),
            'total_geral'=> round($total_geral,4)
        ];
        return $result;
    }

    public  function geraPdfEstimadosEfetuados($mes,$ano){
        setlocale(LC_ALL, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
        $mes_extenso = utf8_encode(ucfirst(strftime('%B / %Y', mktime(0, 0, 0, $mes, 1, $ano))));

        $condominio = Condominio::all('nome_fantasia');
        foreach ($condominio as $item){
            $nome_condominio = $item->nome_fantasia;
        }

        $resumo = $this->resumoEstimadosEfetuados($mes,$ano);

        $dados = Estimado::join('grupo_lancamentos','estimados.id_grupolancamento','grupo_lancamentos.id')
            ->join('tipo_lancamentos','estimados.id_tipolancamento','tipo_lancamentos.id')
            ->where('mes_competencia',$mes)
            ->where('ano_competencia',$ano)
            ->select('grupo_lancamentos.id as id_grupo','grupo_lancamentos.descricao as grupo','tipo_lancamentos.descricao as tipo','estimados.valor')
            ->orderBy('grupo_lancamentos.descricao','ASC')
            ->orderBy('tipo_lancamentos.descricao','ASC')
            ->get();

        if (count($dados) === 0) {
            return response()->error('Sem dados para o relatório desse período!');
        }
        //colocando o resultado da consulta acessível a classe
        $this->arrDados = $dados;
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        $html = "<table style='border-collapse: collapse; width: 100%;'>
                    <tbody>
                        <tr><td align='center' colspan='2'>
                            <row>
                                <img style='float: left;padding: 1px;width: 80px;' src='".$path_logo."'><br>
                                <h2>$nome_condominio</h2><br>
                                LANÇAMENTOS ESTIMADOS<br>
                                ".$mes_extenso."
                            </row>
                        </td></tr>";

        $html .= "<tr><th><td style='text-align: center;border: 1px solid'><b>PREVISTO</b></td></th></tr>";
        $aux = 0;
        //grupos e tipos dos dados de lançamentos estimados
        foreach ($dados as $items) {
            if( $aux != $items->id_grupo){
                if($aux != 0) { $html .= "<tr><td>&nbsp;</td></tr>"; }
                $aux = $items->id_grupo;
                $html .= "<tr style='background-color: #7acd75; border: 1px solid;'>
                            <th style='text-align: left; padding: 8px;'>$items->grupo</th>
                            <th style='text-align: right; padding: 8px; border: 1px solid; margin-left: 10px;'>R$ ".$this->soma_despesas($items->id_grupo)."</th>
                        </tr>";
            }

            $html .= "<tr style='border: 1px solid;'>
                        <td style='text-align: left; padding: 8px'>$items->tipo</td>
                        <td style='text-align: right; border: 1px solid; margin-left: 10px;'>".DataHelper::getDoubleToReal($items->valor)."</td>
                    </tr>";
        }
        //items do RESUMO 
        $html .= "<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
                        <tr style='background-color: #BBC7F4; border: 1px solid;'>
                            <th style='text-align: left; padding: 8px;border:1px solid;'>TOTAL GERAL DE DESPESAS</th>
                            <th style='text-align: right; padding: 8px;border:1px solid;'>R$ ".DataHelper::getDoubleToReal($resumo["total_geral"])."</th>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>TOTAL DESPESAS COM FUNDO DE RESERVA</td>
                            <td style='text-align: right;border:1px solid;'>".DataHelper::getDoubleToReal($resumo["total_despesas_com_fundo"])."</td>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>VALOR DO FUNDO RESERVA</td>
                            <td style='text-align: right;border:1px solid;'>".DataHelper::getDoubleToReal($resumo["total_fundo_reserva"])."</td>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>TOTAL DESPESAS SEM FUNDO DE RESERVA</td>
                            <td style='text-align: right;border:1px solid;'>".DataHelper::getDoubleToReal($resumo["total_despesas_sem_fundo"])."</td>
                        </tr>";
        $total_rateio = ($resumo["valor_rateio_m2"] + $resumo["valor_rateio_fundo"]);
        $html .= "<tr><td>&nbsp;</td></tr>
                        <tr style='background-color: #BBC7F4; border: 1px solid;'>
                            <th style='text-align: left; padding: 8px;border:1px solid;'>TOTAL GERAL DO RATEIO (R$/M²)</th>
                            <th style='text-align: right; padding: 8px;border:1px solid;'>R$ ".DataHelper::getxDecimalCurrency($total_rateio,6)."</th>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>VALOR DO RATEIO (R$/M²)</td>
                            <td style='text-align: right;border:1px solid;'>".DataHelper::getxDecimalCurrency($resumo["valor_rateio_m2"],6)."</td>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>VALOR RATEIO FUNDO DE RESERVA (R$/M²)</td>
                            <td style='text-align: right;border:1px solid;'>".DataHelper::getxDecimalCurrency($resumo["valor_rateio_fundo"],6)."</td>
                        </tr>";
        $html .= "<tr><td><br><br><br><br><br></td></tr>";
        $html .= "<tr><td>Goiânia,_____ de __________________ de ___________</td></tr>";
        $html .= "<tr><td><br><br><br><br><br></td></tr>";
        $html .= "<tr><td colspan='2' align='center'>______________________________________________________________________________________</td></tr>";
        $html .= "<tr><td colspan='2' align='center'>Presidente</td></tr>";

        $html .= " </tbody>
                 </table>";
//        return $html;
//        $mpdf = new \mPDF('', '', 10, '', 8, 8, 10, 15, 1, 8) ;
        $uasdgf = new \mPDF('','','','','','','','','','','');
        $mpdf = new PrintPdf('', '','','',10,10,5,5);
        $mpdf->WriteHTML($html);
        return response($mpdf->Output('Previsão_'.$mes_extenso.'_'.$ano.".pdf", "I"), 200)->header('Content-Type', 'application/pdf');
    }

    public function soma_despesas($id){
        $soma = 0;
        foreach ($this->arrDados as $items){
            if($items->id_grupo == $id){
                $soma += $items->valor;
            }
        }
        $total = DataHelper::getDoubleToReal($soma);
        return  $total;
    }
}
