<?php

namespace App\Http\Controllers;

use App\Http\Requests\ConfiguracaoCarteiraRequest;
use App\Models\ConfiguracaoCarteira;
use Doctrine\DBAL\Query\QueryException;
use League\Flysystem\Exception;

class ConfiguracaoCarteiraController extends Controller
{
    private $name = 'Configuração Conta Bancaria';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = ConfiguracaoCarteira::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  ConfiguracaoCarteiraRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(ConfiguracaoCarteiraRequest $request)
    {
        try {
            $data = $request->all();
            $Data = ConfiguracaoCarteira::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = ConfiguracaoCarteira::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  ConfiguracaoCarteiraRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(ConfiguracaoCarteiraRequest $request, $id)
    {
        $Data = ConfiguracaoCarteira::find($id);
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

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $Data = ConfiguracaoCarteira::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }catch (QueryException $q){
                if($q->getCode()=="23000"){
                    return response()->error("Este registro não pode ser excluido. Há registro(s) de  informações associado(s) a ele.");
                }
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }

    }
}
