<?php

namespace App\Http\Controllers;

use App\Models\TipoDocumento;
use App\Http\Requests\TipoDocumentoRequest;
use Illuminate\Database\QueryException;

class TipoDocumentoController extends Controller
{
    private $name = 'Tipo de Documento';

    public function index()
    {
        $Data = TipoDocumento::all();
        return response()->success($Data);
    }

    public function store(TipoDocumentoRequest $request)
    {
        try{
            $data = $request->all();
            TipoDocumento::create($data);
        } catch (Exception $e){
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.MSS',['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = TipoDocumento::find($id);
        if(count($Data)){
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE',['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  TipoDocumentoRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(TipoDocumentoRequest $request, $id)
    {
        $Data = TipoDocumento::find($id);
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

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $Data = TipoDocumento::find($id);
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
}
