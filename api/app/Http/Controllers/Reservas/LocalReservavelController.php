<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\LocalReservavelRequest;
use App\Models\Reservas\DiaInativoLocalReservavel;
use App\Models\Reservas\LocalReservavel;
use App\Models\Reservas\PeriodoLocalReservavel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class LocalReservavelController extends Controller
{
    private $name = 'Local Reservável';

    public function index()
    {
        $Data = LocalReservavel::simples();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(LocalReservavelRequest $request)
    {
        //$data = $request->except('_token');
        try {
            $data = $request->all();
            $local = LocalReservavel::create($data);

            if ($local->id) {
                foreach ($data["periodo"] as $key => $periodo) {
                    foreach ($periodo as $item) {
                        $arrPeriodo = ['id_local_reservavel' => $local->id, 'dia_semana' => $key, 'hora_ini' => $item["hora_ini"], 'hora_fim' => $item["hora_fim"], 'valor' => $item["valor"], 'deleted' => $item["deleted"]];
                        if ($item["hora_ini"]) {
                            PeriodoLocalReservavel::insert($arrPeriodo);
                        }
                    }
                }

                foreach ($data["diasInativos"] as $key => $diaInativo) {
                    $arrDiaInativo = ['id_local_reservavel' => $local->id, 'data' => $diaInativo["data"], 'descricao' => $diaInativo["descricao"], 'repetir' => $diaInativo["repetir"]];
                    if ($diaInativo["data"]) {
                        DiaInativoLocalReservavel::insert($arrDiaInativo);
                    }
                }
            }


            return $local->id;

        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function show($id)
    {
        $Data = LocalReservavel::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    private function itensAlterar ($arr) {
        return $arr["id"] and !$arr["deleted"];
    }

    public function update(LocalReservavelRequest $request, $id)
    {
        /*$Data = LocalReservavel::find($id);
        $data = $request->all();
        $Data->update($data);*/

        $data = $request->all();
        $periodo = collect($data["periodo"]);

        foreach ($data["periodo"] as $dia_semana) {
            foreach ($dia_semana as $dia) {
                if (!isset($dia["id"]) && $dia["hora_ini"]) {

                }
            }
            exit();
        }
        /*$editar = $periodo->filter(function ($value, $key) {
            foreach ( as $item) {

            }
        });*/


        /*$editar = array_filter($data["periodo"], "itensAlterar");
        echo "<pre>";
        print_r($editar);
        exit();*/

        /*if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));*/
    }


}