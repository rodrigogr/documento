<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Models\Banco;
use App\Models\ContaBancaria;
use App\Http\Requests\ContaBancariaRequest;
use App\Models\FluxoCaixa;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use League\Flysystem\Exception;

class ContaBancariaController extends Controller
{
    private $name = 'Conta Bancaria';

    public function index(){
       return response()->success(ContaBancaria::all());
    }

    public function store(ContaBancariaRequest $request){
        try {
            $data = $request->all();
            if ($data["saldo_value"] === "-") {
                $data["saldo"] = '-'.$data["saldo"];
            }
            $Data = ContaBancaria::create($data);
            $banco = Banco::select('descricao')->find($data["idbanco"]);
            $fluxo = [
                "id_conta_bancaria" => $Data->id,
                "id_parcela" => $Data->id,
                "valor" => $data["saldo"],
                "data_vencimento" => $data["data_saldo_inicial"],
                "data_pagamento" => $data["data_saldo_inicial"],
                "descricao" => 'Saldo inicial - '.$banco->descricao,
                "tabela" => 'conta_bancarias',
                "fluxo" => $data["saldo_value"] === "+" ? 'RECEITA' : 'DESPESA'
            ];
            FluxoCaixa::create($fluxo);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    public function show($id){
        $Data = ContaBancaria::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function update(ContaBancariaRequest $request, $id){
        $Data = ContaBancaria::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $saldo_fluxo = $data["saldo"];
                if ($data["saldo_value"] === "-") {
                    $data["saldo"] = '-'.$data["saldo"];
                }
                $Data->update($data);
                $fluxo = [
                    "valor" => $saldo_fluxo,
                    "data_vencimento" => $data["data_saldo_inicial"],
                    "data_pagamento" => $data["data_saldo_inicial"],
                    "fluxo" => $data["saldo_value"] === "+" ? 'RECEITA' : 'DESPESA'
                ];
                FluxoCaixa::where('id_parcela',$Data->id)->where('tabela','conta_bancarias')->update($fluxo);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = ContaBancaria::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            } catch (QueryException $q){
                if($q->getCode()=="23000"){
                    return response()->error("Este registro não pode ser excluido. Há registro(s) de informações associado(s) a ele.");
                }
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.FGE', ['name' => $this->name]));
        }

    }

    public function carteirasDisponiveis(){
        $Data = ContaBancaria::join('bancos','conta_bancarias.idbanco', '=', 'bancos.id')
            ->join('configuracao_carteiras','conta_bancarias.id', '=', 'configuracao_carteiras.id_conta_bancaria')
            ->join('carteiras','configuracao_carteiras.id_carteira', '=', 'carteiras.id')
            ->join('receitas','conta_bancarias.id', '=', 'receitas.id_configuracao_carteira','left')
            ->select('configuracao_carteiras.id','configuracao_carteiras.id_conta_bancaria', 'conta_bancarias.conta','carteiras.descricao as carteira','carteiras.id as id_carteira',
                \DB::raw('(CASE WHEN conta_bancarias.id = receitas.id_configuracao_carteira THEN 1 ELSE 0 END) AS padrao'), 'bancos.descricao as banco')
            ->get() ;
        if (count($Data)) {
            $result =[];
            $i = 0;
            foreach ($Data as $item){
                $result[$i]= [
                    'descricao'=>$item->banco . ' - '. $item->conta . ' - ' . $item->carteira,
                    'id_conta_bancaria' => $item->id_conta_bancaria,
                    'id_carteira_conta'=> $item->id,
                    'id_carteira'=> $item->id_carteira,
                    'padrao'=>$item->padrao
                ];
                $i++;
            }
            return response()->success($result);
        }
        return response()->success([]);
    }

    public function select(){
        $result = [];
        $Data = ContaBancaria::leftjoin('bancos','conta_bancarias.idbanco', '=', 'bancos.id')
            ->select('bancos.descricao as banco','conta_bancarias.tipo_banco','conta_bancarias.descricao', 'conta_bancarias.conta',
                'conta_bancarias.id as id_conta_bancaria', 'conta_bancarias.agencia')
            ->get() ;
        if (count($Data)) {
            foreach ($Data as $item){
                $descricao = $item->tipo_banco === 'caixa' ? $item->descricao : $item->banco . ' - '. $item->conta;
                array_push($result, [
                    'descricao' => $descricao,
                    'id_conta_bancaria' => $item->id_conta_bancaria
                ]);
            }
        }
        return response()->success($result);
    }

    public function search(Request $request)
    {
        $dia_ini = $request["dia_inicial"];
        $dia_fim = $request["dia_fim"];
        $filtroSaldo = ContaBancaria::whereBetween('data_saldo_inicial',[$dia_ini,$dia_fim])->get();
        return response()->success($filtroSaldo);
    }
}
