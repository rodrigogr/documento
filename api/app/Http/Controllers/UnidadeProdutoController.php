<?php

namespace App\Http\Controllers;

use App\Models\UnidadeProduto;
use App\Http\Requests\UnidadeProdutoRequest;

class UnidadeProdutoController extends Controller
{
    private $name = 'Unidade de Produto';

    public function index()
    {
        $Data = UnidadeProduto::paginate(13);
        return response($Data);
    }

    public function store(UnidadeProdutoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = UnidadeProduto::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = UnidadeProduto::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function update(UnidadeProdutoRequest $request, $id)
    {
        $Data = UnidadeProduto::find($id);
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

    public function destroy($id)
    {
        $Data = UnidadeProduto::find($id);
        $produto = \App\Models\Produto::where('idunidade_produto',$id)->value('id');
        if($produto == null){
            if (count($Data)) {
                try {
                    $Data->delete();
                } catch (Exception $e) {
                    return response()->error($e->getMessage);
                }
                return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
            } else {
                return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
            }
        }else{
            return response()->error(array("produto"=>"Não é Possivel remover Unidade de Produto relacionado a um produto!"));
        }
    }
}
