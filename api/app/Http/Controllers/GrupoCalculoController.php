<?php
namespace App\Http\Controllers;

use App\Http\Requests\GrupoCalculoRequest;
use App\Models\GrupoCalculo;
use League\Flysystem\Exception;
use Illuminate\Http\Request;

class GrupoCalculoController extends Controller
{
    private $name = 'Grupo Calculo';

    public function index(Request $request)
    {
        return isset($request['page']) ? response(GrupoCalculo::paginate(13)) : response()->success(GrupoCalculo::get());
    }

    public function store(GrupoCalculoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = GrupoCalculo::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = GrupoCalculo::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(Request $request, $id)
    {
        $Data = GrupoCalculo::find($id);
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
        $Data = GrupoCalculo::find($id);
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
}