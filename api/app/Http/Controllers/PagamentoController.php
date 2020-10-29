<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Http\Requests\PagamentoRequest;
use App\Models\Empresa;
use App\Models\FluxoCaixa;
use App\Models\ParcelaPagar;
use App\Services\FluxoCaixaServices;
use Illuminate\Http\Request;
use League\Flysystem\Exception;
use Symfony\Component\VarDumper\Cloner\Data;

class PagamentoController extends Controller
{
    private $name = 'Pagamento';

    public function index()
    {
        $result =[];
        $Data = ParcelaPagar::join('lancamento_agendar', 'lancamento_agendar.id', '=', 'parcela_pagar.id_lancamento_agendar')
            ->select('parcela_pagar.id', 'parcela_pagar.tipo_operacao', 'lancamento_agendar.descricao', 'lancamento_agendar.id_fornecedor', 'lancamento_agendar.data_base',
                    'parcela_pagar.data_pagamento', 'parcela_pagar.forma_pagamento', 'parcela_pagar.valor_pago')
            ->orderBy('parcela_pagar.data_base')
            ->get();
        if(count($Data)){
            $i=0;
            $data = [];
            foreach ($Data as $item){
                $fornecedor = Empresa::find($item->id_fornecedor);
                $result[$i]=[
                    'id_parcela'=>$item->id,
                    'status'=>$item->tipo_operacao,
                    'descricao'=> $item->descricao,
                    'fornecedor'=>$fornecedor->nome_fantasia,
                    'data_pagamento'=>$item->data_pagamento,
                    'forma_pagamento'=>$item->forma_pagamento,
                    'valor'=>$item->valor_pago
                ];
                $i++;
            }
        }
        return response()->success($result);
    }

    public function show($id)
    {
        $Data = ParcelaPagar::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function pagar(PagamentoRequest $request)
    {
        try {
            \DB::beginTransaction();
            $data = $request->all();
            foreach ($data['parcelas'] as $parcela) {
                $parcela_pagar = ParcelaPagar::find($parcela['id']);
                $parcela["tipo_operacao"] = 'Débito';
                $parcela_pagar->update($parcela);

                //FLUXO DE CAIXA
                $fluxo = [
                    'id_conta_bancaria' => $parcela['id_conta_bancaria'],
                    'id_parcela' => $parcela['id'],
                    'valor' => $parcela['valor'],
                    'data_vencimento' => DataHelper::setDate($parcela['data_base']),
                    'data_pagamento' => DataHelper::setDate($parcela['data_pagamento']),
                    'fluxo' => 'DESPESA',
                    'tabela' => 'parcela_pagar',
                    'descricao' => 'Nº Doc '.$parcela_pagar["numero_comprovante"].' - '.$parcela['descricao'],
                    'referente' => $parcela['fornecedor']
                ];
                if (FluxoCaixa::where('id_parcela',$parcela['id'])->where('tabela','parcela_pagar')->first()) {
                    FluxoCaixaServices::updateFluxo($fluxo);
                } else {
                    FluxoCaixaServices::createFluxo($fluxo);
                }
            }
            \DB::commit();
            return response()->success('Pagamento realizado!');
        }catch (Exception $e){
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }

    public function estornar(PagamentoRequest $request)
    {
        try {
            \DB::beginTransaction();
            $data = $request->all();
            foreach ($data['parcelas'] as $parcela) {
                $parcela_pagar = ParcelaPagar::find($parcela['id']);
                $parcela_pagar->tipo_operacao = 'Provisão';
                $parcela_pagar->forma_pagamento = $parcela_pagar->forma_pagamento_origem;
                $parcela_pagar->data_pagamento = '';
                $parcela_pagar->data_compensacao = '';
                $parcela_pagar->update();

                //PARA CLIENTES QUE CONTINHAM DADOS MAS NÃO TINHA FLUXO DE CAIXA
                if (!FluxoCaixa::where('id_parcela',$parcela['id'])->where('tabela','parcela_pagar')->first()) {
                    $fluxo_cria = [
                        'id_conta_bancaria' => $parcela_pagar['id_conta_bancaria'],
                        'id_parcela' => $parcela_pagar['id'],
                        'valor'=> $parcela_pagar->valor_pago,
                        'data_vencimento' => DataHelper::setDate($parcela_pagar['data_base']),
                        'data_pagamento' => DataHelper::setDate($parcela_pagar['data_pagamento']),
                        'fluxo' => 'DESPESA',
                        'tabela' => 'parcela_pagar',
                        'descricao' => 'Nº Doc '.$parcela_pagar["numero_comprovante"].' - '.$parcela['descricao'],
                        'referente' => $parcela_pagar->lancamento_agendar->empresa->nome_fantasia
                    ];
                    FluxoCaixaServices::createFluxo($fluxo_cria);
                }
                //ATUALIZA FLUXO DE CAIXA
                $fluxo_alt = [
                    'id_parcela' => $parcela["id"],
                    'data_pagamento' => null,
                    'tabela' => 'parcela_pagar',
                    'valor'=> $parcela_pagar->valor_pago,
                    'fluxo'=> 'DESPESA'
                ];
                FluxoCaixaServices::updateFluxo($fluxo_alt);
                //CRIA NOVO REGISTRO DESSE FLUXO DE ESTORNO - SEM ID_PARCELA
                $fluxo = [
                    'id_conta_bancaria' => $parcela_pagar['id_conta_bancaria'],
                    'valor' => $parcela['valor'],
                    'data_vencimento' => DataHelper::setDate($parcela['data_base']),
                    'data_pagamento' => Date('Y-m-d'),
                    'fluxo' => 'RECEITA',
                    'tabela' => 'parcela_pagar',
                    'descricao' => 'Estorno - Nº Doc '.$parcela_pagar["numero_comprovante"].' - '.$parcela['descricao'],
                    'referente' => $parcela_pagar->lancamento_agendar->empresa->nome_fantasia,
                    'estorno' => true
                ];
                FluxoCaixaServices::createFluxo($fluxo);
            }
            \DB::commit();
            return response()->success('Estorno realizado!');
        }catch (Exception $e){
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }

    public function filtroByDataVencimento(Request $request){
        $result =[];
        $data = $request->all();
        if(isset($data['data_inicio']) && isset($data['data_fim'])) {
            $data_ini = DataHelper::setDate($data['data_inicio']);
            $data_fim = DataHelper::setDate($data['data_fim']);
            $Data = ParcelaPagar::join('lancamento_agendar', 'lancamento_agendar.id', '=', 'parcela_pagar.id_lancamento_agendar')
                ->select('parcela_pagar.id', 'parcela_pagar.tipo_operacao', 'parcela_pagar.id_conta_bancaria', 'lancamento_agendar.descricao', 'lancamento_agendar.id_fornecedor', 'parcela_pagar.data_base',
                    'parcela_pagar.data_pagamento', 'parcela_pagar.forma_pagamento', 'parcela_pagar.valor_pago')
                ->where('tipo_operacao', $data['tipo']);
            if ($data["tipo"] === 'Débito') {
                $Data = $Data->whereBetween('parcela_pagar.data_pagamento',[$data_ini, $data_fim])->orderBy('parcela_pagar.data_pagamento','DESC')->orderBy('parcela_pagar.id','DESC');
            } else {
                $Data = $Data->whereBetween('parcela_pagar.data_base',[$data_ini, $data_fim])->orderBy('parcela_pagar.data_base','DESC');
            }
        } else {
            $Data = ParcelaPagar::join('lancamento_agendar', 'lancamento_agendar.id', '=', 'parcela_pagar.id_lancamento_agendar')
                ->select('parcela_pagar.id', 'parcela_pagar.tipo_operacao', 'parcela_pagar.id_conta_bancaria','lancamento_agendar.descricao', 'lancamento_agendar.id_fornecedor', 'parcela_pagar.data_base',
                    'parcela_pagar.data_pagamento', 'parcela_pagar.forma_pagamento', 'parcela_pagar.valor_pago')
                ->where('tipo_operacao', $data['tipo'])
                ->orderBy('parcela_pagar.id','DESC');
        }
        $Data = $Data->paginate(8);
        foreach ($Data->items() as $item){
            $fornecedor = Empresa::find($item->id_fornecedor);
            $item['valor'] = $item->valor_pago;
            $item['status'] = $item->tipo_operacao;
            $item['fornecedor'] = $fornecedor->nome_fantasia;
        }
        return response($Data);
    }
}
