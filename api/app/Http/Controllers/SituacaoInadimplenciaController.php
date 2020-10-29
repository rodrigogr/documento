<?php

namespace App\Http\Controllers;

use App\Http\Requests\SituacaoInadimplenciaRequest;
use App\Models\SituacaoInadimplencia;
use Illuminate\Database\QueryException;

class SituacaoInadimplenciaController extends Controller
{
    private $name = 'Situação de Inadimplência';

    public function index()
    {
        $Data = SituacaoInadimplencia::paginate(14);
        foreach($Data->items() as $data){
            $data['vmTipo'] = \App\Models\TipoInadimplencia::find($data->idtipo_inadimplencia)->descricao;;
        }
        return response($Data);
    }

    public function comboTipoSituacaoInadimplencia()
    {
        $Data = SituacaoInadimplencia::all();
        foreach ($Data as $item){
            $result[] = $item["id"];
            $result[] = $item["tipo_inadimplencia"]["descricao"].' '.$item["descricao"];
        }
        return response()->success($result);
    }

    
    public function store(SituacaoInadimplenciaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = SituacaoInadimplencia::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = SituacaoInadimplencia::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  SituacaoInadimplenciaRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(SituacaoInadimplenciaRequest $request, $id)
    {
        $Data = SituacaoInadimplencia::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $Data = SituacaoInadimplencia::find($id);
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
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }

    }

    public function situacao_tipo()
    {
        $Data = SituacaoInadimplencia::with('tipo_inadimplencia')->get();
        $i=0;
        foreach ($Data as $item){
            $result[$i]["id"] = $item["id"];
            $result[$i]["descricao"] = $item["tipo_inadimplencia"]["descricao"].' - '.$item["descricao"];
            $i++;
        }
        return response()->success($result);
    }
}
