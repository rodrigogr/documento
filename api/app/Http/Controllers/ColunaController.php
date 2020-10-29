<?php

namespace App\Http\Controllers;

use App\Models\Coluna;
use App\Http\Requests\ColunaRequest;

class ColunaController extends Controller
{
    private $name = 'Coluna';

    public function index($descricao=null)
    {
        if($descricao == null){
            $Data = Coluna::paginate(13);
            return response($Data);
        } else {
            $Data = Coluna::where('descricao', 'like','%'. $descricao .'%')->get();
            return response()->success($Data);
        }
    }

    public function store(ColunaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Coluna::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Coluna::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(ColunaRequest $request, $id)
    {
        $Data = Coluna::find($id);
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
        $Data = Coluna::find($id);
        $produto=\App\Models\Produto::where('idcolunas',$id)->value('id');

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
            return response()->error(array("produto"=>"Não é Possivel remover coluna relacionado a um produto!"));
        }

    }
}
