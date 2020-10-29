<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoInadimplenciaRequest;
use App\Models\TipoInadimplencia;
use Illuminate\Database\QueryException;

class TipoInadimplenciaController extends Controller
{
    private $name = 'Tipo de Inadimplência';

    public function index()
    {
        $Data = TipoInadimplencia::paginate(13);
        return response($Data);
    }

    public function store(TipoInadimplenciaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = TipoInadimplencia::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = TipoInadimplencia::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(TipoInadimplenciaRequest $request, $id)
    {
        $Data = TipoInadimplencia::find($id);
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
        $Data = TipoInadimplencia::find($id);
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

    public function selectList()
    {
        return response()->success(TipoInadimplencia::all());
    }
}
