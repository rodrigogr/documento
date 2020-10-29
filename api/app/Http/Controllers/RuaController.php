<?php

namespace App\Http\Controllers;

use App\Models\Rua;
use App\Http\Requests\RuaRequest;

class RuaController extends Controller
{
    private $name = 'Rua';

    public function index($descricao=null)
    {
        if($descricao == null){
            $Data = Rua::paginate(13);
            return response($Data);
        } else {
            $Data = Rua::where('descricao', 'like','%'. $descricao .'%')->get();
            return response()->success($Data);
        }
    }

    public function store(RuaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Rua::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Rua::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(RuaRequest $request, $id)
    {
        $Data = Rua::find($id);
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
        $Data = Rua::find($id);
        $produto=\App\Models\Produto::where('idrua',$id)->value('id');

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
        }
        else{
            return response()->error(array("produto"=>"Não é Possivel remover rua relacionado a um produto!"));
        }
    }
}
