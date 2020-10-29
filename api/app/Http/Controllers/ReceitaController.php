<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 16/01/17
 * Time: 16:15
 */

namespace App\Http\Controllers;


use App\Http\Requests\ReceitaRequest;
use App\Models\Receita;
use League\Flysystem\Exception;

class ReceitaController extends Controller
{
    private $name = 'Receita';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = Receita::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Receita::find($id);
        if(count($Data)){
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    public function store(ReceitaRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Receita::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function update(ReceitaRequest $request, $id)
    {
        $Data = Receita::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }

    }
}
