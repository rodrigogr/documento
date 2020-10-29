<?php

namespace App\Http\Controllers;

use App\Models\Sequencia;
use App\Http\Requests\SequenciaRequest;

class SequenciaController extends Controller
{
    private $name = 'Sequencia';

    public function index($descricao=null)
    {
        if($descricao == null){
            $Data = Sequencia::paginate(13);
            return response($Data);
        } else {
            $Data = Sequencia::where('descricao', 'like','%'. $descricao .'%')->get();
            return response()->success($Data);
        }
    }

    public function store(SequenciaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Sequencia::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Sequencia::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(SequenciaRequest $request, $id)
    {
        $Data = Sequencia::find($id);
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
        $Data = Sequencia::find($id);
        $produto=\App\Models\Produto::where('idsequencia',$id)->value('id');

        if($produto == null){
            if (count($Data)) {
                try {
                    $Data->delete();
                } catch (Exception $e) {
                    return response()->error($e->getMessage);
                }
                return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
            } else {
                return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
            }
        }else{
            return response()->error(array("produto"=>"Não é Possivel remover sequência relacionado a um produto!"));
        }
    }
}
