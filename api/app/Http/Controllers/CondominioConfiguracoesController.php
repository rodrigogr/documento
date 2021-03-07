<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 16/01/17
 * Time: 16:15
 */

namespace App\Http\Controllers;


use App\Http\Requests\CondominioConfiguracoesRequest;
use App\Models\Condominio;
use App\Models\CondominioConfiguracoes;
use League\Flysystem\Exception;

class CondominioConfiguracoesController extends Controller
{
    private $name = 'Condomínio Configurações';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = CondominioConfiguracoes::all();
        if (!empty($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(CondominioConfiguracoesRequest $request)
    {
        try {
            $data = $request->all();
            $Data = CondominioConfiguracoes::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = CondominioConfiguracoes::find($id);
        if (!empty($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(CondominioConfiguracoesRequest $request, $id)
    {
        $Data = CondominioConfiguracoes::find($id);
        if (!empty($Data)) {
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

    public function condominio()
    {
        $Data = Condominio::select('nome_fantasia')->first();
        if (!empty($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

}