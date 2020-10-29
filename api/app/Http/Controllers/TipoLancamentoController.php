<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoLancamentoRequest;
use App\Models\TipoLancamento;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;

class TipoLancamentoController extends Controller
{
    private $name = 'Tipo de Lançamento';

    public function index(Request $request)
    {
        $data = $request->all();
        if(isset($data['page'])){
            $Data = TipoLancamento::orderBy('descricao')->paginate(14);
            foreach($Data->items() as $data){
                $data['vmGrupo'] = \App\Models\GrupoLancamento::find($data->idgrupo_lancamento)->descricao;;
            }
            return response($Data);
        }
        $Data = TipoLancamento::orderBy('descricao')->get();
        return response()->success($Data);
    }

    public function store(TipoLancamentoRequest $request)
    {
        try {
            $data = $request->all();
            $valid = TipoLancamento::where('descricao', '=', $data['descricao'])
                ->where('idgrupo_lancamento','=',$data['idgrupo_lancamento'])
                ->where('fluxo','=',$data['fluxo'])->get();
            if(count($valid)){
                return response()->error('Plano de contra já cadastrado com o mesmo grupo e fluxo!');
            }

            $Data = TipoLancamento::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = TipoLancamento::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(TipoLancamentoRequest $request, $id)
    {
        $Data = TipoLancamento::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id)
    {
        $Data = TipoLancamento::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
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

    public function listarPorFluxo($fluxo)
    {
        $Data = TipoLancamento::where('fluxo','=',$fluxo)->orderBy('descricao')->get();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }
}
