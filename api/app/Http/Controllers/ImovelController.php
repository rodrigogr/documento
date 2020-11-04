<?php

namespace App\Http\Controllers;

use App\Http\Requests\ImovelRequest;
use App\Models\Imovel;

class ImovelController extends Controller
{
    private $name = 'Imóvel';

    public function index()
    {
        $Data = Imovel::complete();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->success(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(ImovelRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Imovel::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = Imovel::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(ImovelRequest $request, $id)
    {
        $Data = Imovel::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id)
    {
        $Data = Imovel::find($id);
        if (count($Data)) {
            try {
                $Data->softdeleted = 1;
                $Data->save();
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->succces(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function pesquisarMoradorPorImovel($quadra, $lote)
    {
        $result = Imovel::join('imovel_permanente', 'imovel.id','=','imovel_permanente.id_imovel')
            ->join('pessoa','imovel_permanente.id_pessoa','=','pessoa.id')
            ->select('imovel.quadra','imovel.lote','pessoa.nome',\DB::connection('portaria')->raw('pessoa.id as pessoa_id'),'imovel.id')
            ->where(\DB::connection('portaria')->raw('imovel.quadra'), 'like','%'. $quadra . '%')
            ->where(\DB::connection('portaria')->raw('imovel.lote'),'like','%' . $lote . '%')
            ->where('imovel_permanente.pessoa_titular','=', true)
            ->where('imovel_permanente.excluido','=','n')
            ->where('imovel_ficticio','!=',1)
            ->get();
        if (count($result)) {
            return response()->success($result);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    public function pesquisarTitularPorImovel($quadra, $lote){
        $result = Imovel::join('imovel_permanente', 'imovel.id','=','imovel_permanente.id_imovel')
            ->join('pessoa','imovel_permanente.id_pessoa','=','pessoa.id')
            ->select('imovel.quadra','imovel.lote','pessoa.nome',\DB::connection('portaria')->raw('pessoa.id as pessoa_id'),'imovel.id')
            ->where(\DB::connection('portaria')->raw('imovel.quadra'), 'like','%' . $quadra . '%')
            ->where(\DB::connection('portaria')->raw('imovel.lote'),'like','%'. $lote . '%')
            ->where('imovel_permanente.pessoa_titular','=', true)
            ->where('imovel_permanente.excluido','=','n')
            ->where('imovel_ficticio','!=',1)
            ->get();
        if (count($result)) {
            return response()->success($result);
        }
        return response()->error('titular não encontrado');
    }
}