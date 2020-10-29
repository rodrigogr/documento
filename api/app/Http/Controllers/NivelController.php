<?php

namespace App\Http\Controllers;

use App\Models\Nivel;
use App\Http\Requests\NivelRequest;

class NivelController extends Controller
{
    private $name = 'Nivel';

    public function index($descricao=null)
    {
        if($descricao == null){
            $Data = Nivel::paginate(13);
            return response($Data);
        }else{
            $Data = Nivel::where('descricao', 'like','%'. $descricao .'%')->get();
            return response()->success($Data);
        }
    }

    public function store(NivelRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Nivel::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Nivel::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(NivelRequest $request, $id)
    {
        $Data = Nivel::find($id);
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
        $Data = Nivel::find($id);
        $produto=\App\Models\Produto::where('idniveis',$id)->value('id');

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
            return response()->error(array("produto"=>"Não é Possivel remover nível relacionado a um produto!"));
        }
    }
}
