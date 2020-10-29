<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Http\Requests\LancamentoRecorrenteRequest;
use App\Models\LancamentoRecorrente;
use App\Models\Lancamento;
use App\Models\ReceitaCalculo;

class LancamentoRecorrenteController extends Controller
{
    private $name = 'Lançamento Recorrente';

    public function index()
    {
        $Data = LancamentoRecorrente::complete();
        for ($i=0;$i<count($Data);$i++) {
            if($Data[$i]->data_ini && $Data[$i]->data_fim) {
                $dataIni = explode("-", $Data[$i]->data_ini);
                $dataFim = explode("-", $Data[$i]->data_fim);
                $Data[$i]->mes_ini = (int)$dataIni[1];
                $Data[$i]->ano_ini = (int)$dataIni[0];
                $Data[$i]->mes_fim = (int)$dataFim[1];
                $Data[$i]->ano_fim = (int)$dataFim[0];
            }
        }
        return response()->success($Data);
    }

    public function store(LancamentoRecorrenteRequest $request)
    {
        try {
            \DB::beginTransaction();
            $data = $request->all();
            $data = array_add($data,'saldo_receber',$data['valor']);
            $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Outros'));
            $lancamento = Lancamento::create($data);
            $data = array_add($data,'id_lancamento',$lancamento->id);
            if(!$data['idlocalidade']){
                $data['idlocalidade'] = null;
            }
            if(!$data["fixo"]) {
                $data["data_ini"] = $data["ano_ini"] . '-' . $data["mes_ini"] . "-01";
                $data["data_fim"] = $data["ano_fim"] . '-' . $data["mes_fim"] . "-" . date("t", mktime(0, 0, 0, $data["mes_fim"], '01', $data["ano_fim"]));
            }
            LancamentoRecorrente::create($data);
            \DB::commit();
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = LancamentoRecorrente::complete($id);
        return response()->success($Data);
    }

    public function update(LancamentoRecorrenteRequest $request, $id)
    {
        $lancamento = Lancamento::find($id);
        $Data = LancamentoRecorrente::find($id);
        if (count($Data)) {
            try {
                \DB::beginTransaction();
                $data = $request->all();
                if(!$data['idlocalidade']){
                    $data['idlocalidade'] = null;
                }
                $lancamento->update($data);
                $data["data_ini"] = $data["ano_ini"].'-'.$data["mes_ini"]."-01";
                $data["data_fim"] = $data["ano_fim"].'-'.$data["mes_fim"]."-".date("t", mktime(0,0,0,$data["mes_fim"],'01',$data["ano_fim"]));
                $Data->update($data);
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id)
    {
        $Data = LancamentoRecorrente::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
                $lancamento = Lancamento::find($id);
                $lancamento->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function simulacoesCalculadas()
    {
        $Data = ReceitaCalculo::selectRaw('month(data_vencimento) as mes, year(data_vencimento) as ano')->get();
        return response()->success($Data);
    }
}