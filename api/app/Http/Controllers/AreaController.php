<?php

namespace App\Http\Controllers;

use App\Models\Area;
use App\Http\Requests\AreaRequest;

class AreaController extends Controller
{
    private $name = 'Area';

    public function index($descricao=null)
    {
        $Data = Area::paginate(13);
        return response($Data);
    }

    public function store(AreaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Area::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Area::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(AreaRequest $request, $id)
    {
        $Data = Area::find($id);
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
        $produto=\App\Models\Produto::where('idarea',$id)->value('id');

        if($produto == null){
            $Data = Area::find($id);
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
            return response()->error(array("produto"=>"Não é Possivel remover área relacionado a um produto!"));
        }

    }
}
