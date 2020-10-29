<?php

namespace App\Http\Controllers;

use App\Models\Banco;
use App\Http\Requests\BancoRequest;
use Doctrine\DBAL\Query\QueryException;
use League\Flysystem\Exception;

class BancoController extends Controller
{
    private $name = 'Banco';

    public function index(){
        return response()->success(Banco::all());
    }

    public function store(BancoRequest $request){
        try {
            $data = $request->all();
            $Data = Banco::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id){
        $Data = Banco::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(BancoRequest $request, $id){
        $Data = Banco::find($id);
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

    public function destroy($id){
        try {
            $Data = Banco::find($id);            
            $Data->delete();
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } catch (\Exception $e) {
            if($e->getCode()=="23000"){
                return response()->error("Este registro não pode ser excluido. Há registro(s) de  informações associado(s) a ele.");
            }else{
                return response()->error($e->getMessage);
            }
        }
    }
}
