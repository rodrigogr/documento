<?php

namespace App\Http\Controllers;

use App\Http\Requests\LancamentoAgendarRequest;
use App\Models\AcrescimoPagar;
use App\Models\Empresa;
use App\Models\FluxoCaixa;
use App\Models\LancamentoAgendar;
use App\Models\Pedido;
use App\Models\Condominio;
use App\Models\ParcelaPagar;
use App\Services\FluxoCaixaServices;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Storage;
use League\Flysystem\Exception;
use App\Helpers\DataHelper;
use Illuminate\Http\Request;

class LancamentoAgendarController extends Controller
{
    private $name = 'Conta à pagar';

    public function index(Request $request){
        $req = $request->input();
        $Data = LancamentoAgendar::with(['parcelas','acrescimos','localidade','empresa','departamento','tipo_lancamento']);
        if(isset($req['data_inicio']) && isset($req['data_fim'])){
            $Data = $Data->whereBetween('data_base',[
                DataHelper::setDate($req['data_inicio']),
                DataHelper::setDate($req['data_fim'])
            ]);
        }
        $Data = $Data->orderBy('id','DESC');
        $Data = $Data->paginate(12);
        return response($Data);
    }

    public function store(LancamentoAgendarRequest $request){
        try {
            \DB::beginTransaction();
            $data = $request->all();
            if($data['numero_nf'] === ""){
                $data['numero_nf'] = null;
            }
            if($data['id_tipo_documento'] === ""){
                $data['id_tipo_documento'] = null;
            }
            if($data['data_emissao_nf'] === ""){
                $data['data_emissao_nf'] = null;
            }
            if($data['id_departamento'] === ""){
                $data['id_departamento'] = null;
            }
            $Data = LancamentoAgendar::create($data);
            //Parcelas
            if($Data){
                if(isset($data['acrescimos'])) {
                    foreach ($data['acrescimos'] as $acrescimo) {
                        if ($acrescimo['incluir_soma'] == "true") {
                            $acrescimo['incluir_soma'] = 1;
                        } else {
                            $acrescimo['incluir_soma'] = 0;
                        }
                        $acrescimo = array_add($acrescimo, 'id_lancamento_agendar', $Data->id);
                        $acrescimo_pagar = AcrescimoPagar::create($acrescimo);
                    }
                }
                if(isset($data['parcelas'])) {
                    foreach ($data['parcelas'] as $parcela) {
                        if (!isset($parcela['data_compensacao'])) {
                            $parcela['data_compensacao'] = null;
                        }
                        if (!isset($parcela['data_pagamento'])) {
                            $parcela['data_pagamento'] = null;
                        }
                        $parcela = array_add($parcela, 'id_lancamento_agendar', $Data->id);
                        $parcela = array_add($parcela, 'forma_pagamento_origem', $parcela['forma_pagamento']);
                        $parcela_pagar = ParcelaPagar::create($parcela);
                        //FLUXO DE CAIXA
                        if ($parcela["tipo_operacao"] === 'Débito') {
                            $fluxo_param["data_pagamento"] = $parcela["data_pagamento"];
                        } else {
                            $fluxo_param["data_pagamento"] = null;
                        }
                        $fluxo_param["fluxo"] = 'DESPESA';
                        $fluxo = [
                            'id_conta_bancaria' => $parcela["id_conta_bancaria"],
                            'id_parcela' => $parcela_pagar->id,
                            'valor' => $parcela["valor_pago"],
                            'data_vencimento' => $parcela["data_base"],
                            'data_pagamento' => $fluxo_param["data_pagamento"],
                            'fluxo' => $fluxo_param["fluxo"],
                            'tabela' => 'parcela_pagar',
                            'descricao' => $parcela_pagar->forma_pagamento.' '.$parcela_pagar->numero_comprovante.' - '.$parcela["nome"].$data["descricao"],
                            'referente' => $Data->empresa->nome_fantasia
                        ];
                        FluxoCaixaServices::createFluxo($fluxo);
                    }
                }
            }
            if(isset($data['idCompra'])){
                $compra = Pedido::find($data['idCompra']);
                $compra['status'] = 'Compra Provisionada';
                $compra['id_lancamento_agendar'] = $Data['id'];
                $compra->save();
            }
            \DB::commit();
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id){
        $Data = LancamentoAgendar::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(LancamentoAgendarRequest $request, $id=null){
        $Data = LancamentoAgendar::find($id);
        if (count($Data)) {
            try {
                \DB::beginTransaction();

                $data = $request->all();

                if(!$data['numero_nf']){
                    $data['numero_nf'] = null;
                }
                if(!$data['id_tipo_documento']){
                    $data['id_tipo_documento'] = null;
                }
                if(!isset($data["data_emissao_nf"])){
                    $data["data_emissao_nf"] = null;
                }
                if(!isset($data["id_departamento"])){
                    $data['id_departamento'] = null;
                }

                $Data->update($data);

                if(isset($data['acrescimos'])) {
                    foreach ($data['acrescimos'] as $acrescimo) {
                        if ($acrescimo['incluir_soma'] == "true") {
                            $acrescimo['incluir_soma'] = 1;
                        } else {
                            $acrescimo['incluir_soma'] = 0;
                        }

                        if (isset($acrescimo['id'])) {
                            $acrescimo_pagar = AcrescimoPagar::find($acrescimo['id']);
                            if(count($acrescimo_pagar)) {
                                if ($acrescimo['deleted'] == "true") {
                                    $acrescimo_pagar->delete();
                                } else {
                                    $acrescimo_pagar->update($acrescimo);
                                }
                            }
                        } else {
                            $acrescimo = array_add($acrescimo, 'id_lancamento_agendar', $Data->id);
                            AcrescimoPagar::create($acrescimo);
                        }
                    }
                }

                if(isset($data['parcelas'])) {
                    foreach ($data['parcelas'] as $parcela) {

                        if (!isset($parcela['data_compensacao'])) {
                            $parcela['data_compensacao'] = null;
                        }
                        if (!isset($parcela['data_pagamento'])) {
                            $parcela['data_pagamento'] = null;
                        }
                        if (isset($parcela['id'])) {
                            $parcela_pagar = ParcelaPagar::find($parcela['id']);
                            if(count($parcela_pagar)) {
                                if ($parcela['deleted'] == 1) {
                                    $parcela_pagar->delete();
                                    FluxoCaixa::where('id_parcela',$parcela['id'])->where('tabela','parcela_pagar')->delete();
                                } else {
                                    //verificando se cliente tem dados mas não tem fluxo
                                    if (!FluxoCaixa::select('id_parcela')->where('id_parcela',$parcela["id"])->where('tabela','parcela_pagar')->first()) {
                                        $fluxo_alt = [
                                            'id_parcela' => $parcela["id"],
                                            'id_conta_bancaria' => $parcela["id_conta_bancaria"],
                                            'valor' => $parcela["valor_pago"],
                                            'data_vencimento' => DataHelper::setDate($parcela["data_base"]),
                                            'data_pagamento' => ($parcela["tipo_operacao"] === 'Débito') ? DataHelper::setDate($parcela["data_pagamento"]) : null,
                                            'fluxo' => 'DESPESA',
                                            'tabela' => 'parcela_pagar',
                                            'descricao' => $parcela_pagar->forma_pagamento.' '.$parcela_pagar->numero_comprovante.' - '.$Data->descricao,
                                            'referente' => $Data->empresa->nome_fantasia
                                        ];
                                        FluxoCaixaServices::createFluxo($fluxo_alt);
                                    } else {
                                        if (is_null($parcela_pagar->data_pagamento)) {
                                            $fluxo_alt = [
                                                'id_parcela' => $parcela["id"],
                                                'id_conta_bancaria' => $parcela["id_conta_bancaria"],
                                                'valor' => $parcela["valor_pago"],
                                                'data_vencimento' => DataHelper::setDate($parcela["data_base"]),
                                                'data_pagamento' => ($parcela["tipo_operacao"] === 'Débito') ? DataHelper::setDate($parcela["data_pagamento"]) : null,
                                                'fluxo' => 'DESPESA',
                                                'tabela' => 'parcela_pagar',
                                                'descricao' => $parcela_pagar->forma_pagamento.' '.$parcela_pagar->numero_comprovante . ' - ' . $Data->descricao,
                                                'referente' => $Data->empresa->nome_fantasia
                                            ];
                                            FluxoCaixaServices::updateFluxo($fluxo_alt);
                                        }
                                    }

                                    $parcela = array_add($parcela, 'forma_pagamento_origem', $parcela['forma_pagamento']);
                                    $parcela_pagar->update($parcela);
                                }
                            }
                        } else {
                            $parcela = array_add($parcela, 'id_lancamento_agendar', $Data->id);
                            $parcela = array_add($parcela, 'forma_pagamento_origem', $parcela['forma_pagamento']);
                            $parcela_pagar = ParcelaPagar::create($parcela);
                            $fluxo = [
                                'id_conta_bancaria' => $parcela["id_conta_bancaria"],
                                'id_parcela' => $parcela_pagar->id,
                                'valor' => $parcela["valor_pago"],
                                'data_vencimento' => $parcela["data_base"],
                                'data_pagamento' => ($parcela["tipo_operacao"] === 'Débito') ? $parcela["data_pagamento"] : null,
                                'fluxo' => 'DESPESA',
                                'tabela' => 'parcela_pagar',
                                'descricao' => $parcela_pagar->forma_pagamento.' '.$parcela_pagar->numero_comprovante.' - '.$parcela["nome"].' '.$data["descricao"],
                                'referente' => $Data->empresa->nome_fantasia
                            ];
                            FluxoCaixaServices::createFluxo($fluxo);
                        }
                    }
                }
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = LancamentoAgendar::find($id);
        if (count($Data)) {
            try {
                $parcela_pagar = ParcelaPagar::where('id_lancamento_agendar',$Data->id)->where('tipo_operacao','Débito')->get();
                if(count($parcela_pagar)) {
                    return response()->error("Existem parcelas quitadas ou valor de entrada registrado.<br>Necessário realizar o estorno!<br><br><b>Menu->Contas a Pagar->Pagamentos</b>");
                }
                $parcelas = ParcelaPagar::where('id_lancamento_agendar',$Data->id)->get();
                foreach ($parcelas as $parcela) {
                    FluxoCaixa::where('id_parcela',$parcela["id"])->where('tabela','parcela_pagar')->delete();
                }
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }catch (QueryException $q){
                if($q->getCode()=="23000"){
                    return response()->error("Este registro não pode ser excluido. Há registro(s) de  informações associado(s) a ele.");
                }
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function demonstrativo($id){
        $lancamento = LancamentoAgendar::complete($id);
        // return response($lancamento);
        if(!count($lancamento)){
            abort(404);
        //return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
        $html_cabecalho = $this->pdf_cabecalho('Demonstrativo Conta a Pagar');
        $html_title = "";
        $html_infor = "
        <div style=' float: left;width: 100%;display: inline; padding: 8px;'>
            <row style='float: left;width: 100%;'>
                <div style='float: left; width: 100%'><p>Descrição: ".$lancamento->descricao."</p></div>
                <div style='width: 100%'><p>Fornecedor: ".$lancamento->empresa->first()->nome_fantasia ."</p></div>
                <div style='float: left;width: 50%'><p>Número NF: ". $lancamento->numero_nf."</p></div>
                <div style='float: left;width: 50%'><p>Dt. Emissão NF: ".$lancamento->data_emissao_nf."</p></div>
                <div style='float: left;width: 50%'><p>Localização: ".$lancamento->localidade->first()->descricao ."</p></div>
                <div style='float: left;width: 50%'><p>Lancamento: ".$lancamento->tipo_lancamento->first()->descricao ."</p></div>
            </row>
        </div>";
        $html_corpo = "
        <div>
            <table style='border-collapse: collapse; width: 100%'>
                <thead>
                    <tr>
                        <th style='text-align: left; padding: 8px'>OPERAÇÃO</th>
                        <th style='text-align: left; padding: 8px'>VENCIMENTO</th>
                        <th style='text-align: left; padding: 8px'>PAGAMENTO</th>
                        <th style='text-align: left; padding: 8px'>COMPENSAÇÃO</th>
                        <th style='text-align: left; padding: 8px'>VALOR</th>
                    </tr>
                </thead>
            <tbody> ";
        $valorTotal = 0;
        foreach ($lancamento->parcelas as $parcela) {
            $html_corpo .= "
            <tr>
                <td style='text-align: left; padding: 8px'>$parcela->tipo_operacao</td>
                <td style='text-align: left; padding: 8px'>$parcela->data_base</td>
                <td style='text-align: left; padding: 8px'>$parcela->data_pagamento</td>
                <td style='text-align: left; padding: 8px'>$parcela->data_compensacao</td>
                <td style='text-align: left; padding: 8px'>R$ ".DataHelper::getxDecimalCurrency($parcela->valor_pago,2)."</td>
            </tr>";
            $valorTotal = $valorTotal + $parcela->valor_pago;
        };
        $html_corpo .="
                </tbody>
            </table>
        </div>";
        $html_total = " 
        <div style='width: 35%;float: right; padding: 15px'>
            <row style='float: right;'>
                <p>VALOR TOTAL: R$ ".DataHelper::getxDecimalCurrency($valorTotal,2)."</p>
            </row>
        </div>";
        $html = $html_cabecalho . $html_title . $html_infor . $html_corpo . $html_total;
        $mpdf = new \mPDF() ;
        $mpdf->WriteHTML($html);
        return response($mpdf->Output());
    }

    public  function pdf_cabecalho($titulo,$periodo = null){
        $condominio = Condominio::first();
        if(!is_null($periodo)){
            $periodo = '<br><p>Período apurado: '.$periodo.'</p>';
        }

        $pdf_header = "<style>th{ padding:5px 0px;} td{ padding: 3px 0px;}</style>";
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        $pdf_header .= "<table style='width: 100%;'>
                            <tr>
                                <td style='vertical-align: top'>
                                    <img style='padding: 1px;width: 80px;' src='".$path_logo."'><br>
                                    <h3>".$condominio->nome_fantasia."</h3>
                                </td>
                                <td style='text-align:center; vertical-align: bottom;'>
                                    <h2 style='font-size: 20px;text-align:center;padding-bottom: 10px; '>".$titulo."</h2>
                                    ".$periodo."
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                       </table>";
        return $pdf_header;
    }

    public function contasVencidas() {
        $now = date('Y-m-d');
        $Data = LancamentoAgendar::whereHas('parcelas', function($q) use($now){
            $q->where('tipo_operacao','Provisão');
            $q->where('data_base','<',$now);
        })->with(['parcelas','acrescimos','localidade','empresa','departamento','tipo_lancamento'])
        ->orderBy('id','DESC')
        ->paginate(12);
        return response($Data);
    }
}
