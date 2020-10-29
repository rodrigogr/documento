<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Http\Requests\LancamentosEstimadosRequest;
use App\Http\Requests\PrevisaoOrcamentariaRequest;
use App\Models\Condominio;
use App\Models\Estimado;
use App\Models\GrupoCalculo;
use App\Models\Imovel;
use App\Models\LancamentosEstimados;
use App\Models\TipoLancamento;
use App\PrintPdf;
use Doctrine\DBAL\Query\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use League\Flysystem\Exception;

class LancamentosEstimadosController extends Controller
{
    private $name = 'Lançamento Estimado';
    private $arrDados = [];

    public function index(){
        return response()->success(LancamentosEstimados::complete());
    }

    public function store(LancamentosEstimadosRequest $request){
        $Data = LancamentosEstimados::where('id_tipolancamento', '=', $request->get('id_tipolancamento'))
            ->where('id_grupolancamento', '=', $request->get('id_grupolancamento'))->get();
        if (!count($Data)){
            $Data = TipoLancamento::where('id', '=', $request->get('id_tipolancamento'))->where('idgrupo_lancamento', '=', $request->get('id_grupolancamento'))->get();
            if(count($Data)) {
                try {
                    $data = $request->all();
                    $Data = LancamentosEstimados::create($data);
                } catch (Exception $e) {
                    return response()->error(trans($e->getMessage()));
                }
                return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
            }else {
                return response()->error(trans('Tipo de lançamento não pertence ao grupo selecionado.', ['name' => $this->name]));
            }
        } else {
            return response()->error(trans('Esse tipo de lançamento já foi estimado.', ['name' => $this->name]));
        }

    }

    public function update(LancamentosEstimadosRequest $request, $id){
        $Data = LancamentosEstimados::find($id);
        if(count($Data)) {
            $outer = LancamentosEstimados::where('id_tipolancamento', '=', $request->get('id_tipolancamento'))->where('id_grupolancamento', '=', $request->get('id_grupolancamento'))
                ->where('id', '<>', $Data->id)->get();
            if(!count($outer)) {
                $Verify = TipoLancamento::where('id', '=', $request->get('id_tipolancamento'))->where('idgrupo_lancamento', '=', $request->get('id_grupolancamento'))->get();
                if (count($Verify)) {
                    try {
                        $data = $request->all();
                        $Data->update($data);
                    } catch (Exception $e) {
                        return response()->error($e->getMessage());
                    }
                    return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
                } else {
                    return response()->erro(trans('Tipo de lançamento não pertence ao grupo selecionado.', ['name' => $this->name]));
                }
            } else {
                return response()->error(trans('Esse tipo de lançamento já foi estimado.', ['name' => $this->name]));
            }
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = LancamentosEstimados::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            } catch (QueryException $q){
                if($q->getCode()=="23000"){
                    return response()->error("Este registro não pode ser excluido. Há registro(s) de  informações associado(s) a ele.");
                }
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function geraPdfEstimados ($download, $mes = null, $ano = null){
        setlocale(LC_ALL, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
        $condominio = Condominio::all('nome_fantasia');
        foreach ($condominio as $item){
            $nome_condominio = $item->nome_fantasia;
        }

        $resumo = $this->resumo(true);

        $dados = LancamentosEstimados::join('grupo_lancamentos','lancamentos_estimados.id_grupolancamento','grupo_lancamentos.id')
            ->join('tipo_lancamentos','lancamentos_estimados.id_tipolancamento','tipo_lancamentos.id')
            ->select('grupo_lancamentos.id as id_grupo','grupo_lancamentos.descricao as grupo','tipo_lancamentos.descricao as tipo','lancamentos_estimados.valor')
            ->orderBy('grupo_lancamentos.descricao','ASC')
            ->orderBy('tipo_lancamentos.descricao','ASC')
            ->get();

        //colocando o resultado da consulta acessível a classe
        $this->arrDados = $dados;
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        $html = "<table style='border-collapse: collapse; width: 100%;'>
                    <thead>
                        <tr><th>
                            <row>
                                <img style='float: left;padding: 1px; height: 50px; width: 50px;' src='".$path_logo."'>
                            </row>
                        </th></tr>
                        <tr><th><h1>$nome_condominio</h1></th></tr>
                        <tr><th>LANÇAMENTOS ESTIMADOS</th></tr>
                        <tr><th>".utf8_encode(ucfirst(strftime('%B - %Y', strtotime('next month'))))."</th></tr>
                        
                    </thead>
                    <tbody>";
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
                            <th style='text-align: right; padding: 8px;border:1px solid;'>R$ ".number_format($total_rateio,6,',', '.')."</th>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>VALOR DO RATEIO (R$/M²)</td>
                            <td style='text-align: right;border:1px solid;'>".number_format($resumo["valor_rateio_m2"],6,',', '.')."</td>
                        </tr>
                        <tr style='border: 1px solid;'>
                            <td style='text-align: left; padding: 8px;border:1px solid;'>VALOR RATEIO FUNDO DE RESERVA (R$/M²)</td>
                            <td style='text-align: right;border:1px solid;'>".number_format($resumo["valor_rateio_fundo"],6,',', '.')."</td>
                        </tr>";
        $html .= "<tr><td><br><br><br><br><br></td></tr>";
        $html .= "<tr><td>Goiânia,_____ de __________________ de ___________</td></tr>";
        $html .= "<tr><td><br><br><br><br><br></td></tr>";
        $html .= "<tr><td colspan='2' align='center'>______________________________________________________________________________________</td></tr>";
        $html .= "<tr><td colspan='2' align='center'>Presidente</td></tr>";

        $html .= " </tbody>
                 </table>";

        //return $html;
        //$mpdf = new \mPDF('', '', 9, '', 8, 8, 10, 15, 1, 8) ;
        $pdf = new PrintPdf('', '', 9, '', 8, 8, 10, 15, 1, 8);
        $pdf->WriteHTML($html);
        if((boolean)$download) {
            return response($pdf->Output());
//            return response($pdf->Output('Estimativa.pdf', "I"), 200)->header('Content-Type', 'application/pdf');
        } else {
            return response($pdf->Output('','S'));
        }
    }

    public function resumo( $pdf = false){
        $result = [];
        //Busca percentual do fundo de reserva
        $grupo_calculo = GrupoCalculo::all('percentualfundoreserva');
        if(!count($grupo_calculo)){
            return("Nenhum percentual de fundo de reserva cadastrado!");
        }

        //Busca o total de despesas com fundo de Reserva
        $total_depesas = LancamentosEstimados::all()->sum('valor');
        if(!$total_depesas){
            return response()->success($result);
        }
        $total_despesas_sem_fundo = LancamentosEstimados::where('fundo_reserva', '=',0)->sum('valor');
        $total_despesas_fundo = LancamentosEstimados::where('fundo_reserva', '=',1)->sum('valor');
        $areatotal_condominio = Imovel::getAreaTotalCondominio();
        $percentual_fundo_reserva = $grupo_calculo->first()->percentualfundoreserva;
        $total_fundo_reserva = ($total_despesas_fundo * $percentual_fundo_reserva)/100;
        $valor_rateio_m2 = 0;
        $valor_rateio_fundo = 0;
        if ($areatotal_condominio > 0) {
            $valor_rateio_m2 = $total_depesas / $areatotal_condominio;
            $valor_rateio_fundo = $total_fundo_reserva / $areatotal_condominio;
        }
        $total_geral =  $total_depesas + $total_fundo_reserva;

        $result = [
            'total_despesas_com_fundo'=> round($total_despesas_fundo,2),
            'total_fundo_reserva' => round($total_fundo_reserva,2),
            'total_despesas_sem_fundo' => round($total_despesas_sem_fundo,2),
            'total_despesas'=> round($total_depesas,2),
            'valor_rateio_m2'=> round($valor_rateio_m2,6),
            'valor_rateio_fundo'=> round($valor_rateio_fundo,6),
            'total_geral'=> round($total_geral,2)
        ];

        return $pdf ? $result : response()->success($result);

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