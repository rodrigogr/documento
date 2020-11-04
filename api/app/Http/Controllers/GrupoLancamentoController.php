<?php

namespace App\Http\Controllers;

use App\Models\GrupoLancamento;
use App\Http\Requests\GrupoLancamentoRequest;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;


class GrupoLancamentoController extends Controller
{
    private $name = 'Grupo de Lançamento';

    public function index(Request $request)
    {
        $data = $request->all();
        if(isset($data['page'])) {
            $Data = GrupoLancamento::paginate(13);
            return response($Data);
        }
        $Data = GrupoLancamento::orderBy('descricao')->get();
        return response($Data);
    }

    public function store(GrupoLancamentoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = GrupoLancamento::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = GrupoLancamento::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(GrupoLancamentoRequest $request, $id)
    {
        $Data = GrupoLancamento::find($id);
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
        $Data = GrupoLancamento::find($id);
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

    public function gruposLancamentoPorTipo(GrupoLancamentoRequest $request)
    {
        $data = $request->all();
        $Data = \DB::connection('portaria')->table('grupo_lancamentos as g')
            ->join('tipo_lancamentos as l','l.idgrupo_lancamento','g.id')
            ->where('l.fluxo',$data["tipo"])
            ->distinct()
            ->select('g.id','g.descricao')
            ->get();
        return response()->success($Data);

    }
}
