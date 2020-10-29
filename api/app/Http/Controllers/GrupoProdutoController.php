<?php

namespace App\Http\Controllers;

use App\Models\GrupoProduto;
use App\Http\Requests\GrupoProdutoRequest;

class GrupoProdutoController extends Controller
{
    private $name = 'Grupo de Produto';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = GrupoProduto::all();
        //if (count($Data)) {
            return response()->success($Data);
        //}
        //return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  GrupoProdutoRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(GrupoProdutoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = GrupoProduto::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = GrupoProduto::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  GrupoProdutoRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(GrupoProdutoRequest $request, $id)
    {
        $Data = GrupoProduto::find($id);
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
        $Data = GrupoProduto::find($id);

        $produto=\App\Models\Produto::where('idgrupo_produto',$id)->value('id');

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
            return response()->error(array("produto"=>"Não é Possivel remover Grupo de Produto relacionado a um produto!"));
        }

    }
}
