<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\LocalReservavelRequest;
use App\Models\Reservas\DiaInativoLocalReservavel;
use App\Models\Reservas\LocalReservavel;
use App\Models\Reservas\PeriodoLocalReservavel;
use Carbon\Carbon;
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
                        $arrPeriodo = ['id_local_reservavel' => $local->id, 'dia_semana' => $key, 'hora_ini' => $item["hora_ini"], 'hora_fim' => $item["hora_fim"], 'valor' => $item["valor"]];
                        if ($item["hora_ini"]) {
                            PeriodoLocalReservavel::insert($arrPeriodo);
                        }
                    }
                }

                foreach ($data["dia_inativo"] as $diaInativo) {
                    $arrDiaInativo = ['id_local_reservavel' => $local->id, 'data' => $diaInativo["data"], 'descricao' => $diaInativo["descricao"], 'repetir' => $diaInativo["repetir"]];
                    if ($diaInativo["data"]) {
                        $dataFormatada = Carbon::createFromFormat('d/m/Y', $diaInativo["data"])->format('Y-m-d');
                        $arrDiaInativo["data"] = $dataFormatada;
                        DiaInativoLocalReservavel::insert($arrDiaInativo);
                    }
                }
            }

            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));

        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function show($id)
    {
        $Data = LocalReservavel::complete($id);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    private function itensAlterar ($arr) {
        return $arr["id"] and !$arr["deleted"];
    }

    public function update(LocalReservavelRequest $request, $id)
    {
        try {
            $data = $request->all();
            echo "<pre>";
            print_r($data);
            exit();
            $Data = LocalReservavel::find($id);
            $Data->update($data);

            foreach ($data["periodo"] as $key => $dia_semana) {
                foreach ($dia_semana as $dados_dia) {
                    if (!isset($dados_dia["id"]) && $dados_dia["hora_ini"]) {
                        $dados_dia["id_local_reservavel"] = $id;
                        $dados_dia["dia_semana"] = $key;
                        PeriodoLocalReservavel::create($dados_dia);
                    }
                    if (isset($dados_dia["id"]) && $dados_dia["hora_ini"] && (isset($dados_dia["deleted"]) && !$dados_dia["deleted"])) {
                        $periodoAlt = PeriodoLocalReservavel::find($dados_dia["id"]);
                        $periodoAlt->id_local_reservavel = $id;
                        $periodoAlt->dia_semana = $key;
                        $periodoAlt->hora_ini = $dados_dia["hora_ini"];
                        $periodoAlt->hora_fim = $dados_dia["hora_fim"];
                        $periodoAlt->valor = $dados_dia["valor"];
                        $periodoAlt->save();
                    }
                    if (isset($dados_dia["deleted"]) && $dados_dia["deleted"]) {
                        $periodoDel = PeriodoLocalReservavel::find($dados_dia["id"]);
                        $periodoDel->delete();
                    }
                }
            }

            foreach ($data["dia_inativo"] as $dia_inativo) {
                if (!isset($dia_inativo["id"])) {
                    $dia_inativo["id_local_reservavel"] = $id;
                    unset($dia_inativo['deleted']);
//                    $dataFormatada = Carbon::createFromFormat('d/m/Y', $dia_inativo["data"])->format('Y-m-d');
//                    $dia_inativo["data"] = $dataFormatada;
                    DiaInativoLocalReservavel::insert($dia_inativo);
                }
                if (isset($dia_inativo["id"]) && !$dia_inativo["deleted"]) {
//                    $dataFormatada = Carbon::createFromFormat('d/m/Y', $dia_inativo["data"])->format('Y-m-d');
//                    $dia_inativo["data"] = $dataFormatada;
                    $diaAlt = DiaInativoLocalReservavel::find($dia_inativo["id"]);
                    $diaAlt->id_local_reservavel = $id;
                    $diaAlt->data = $dia_inativo["data"];
                    $diaAlt->descricao = $dia_inativo["descricao"];
                    $diaAlt->repetir = $dia_inativo["repetir"];
                    $diaAlt->save();
                }
                if (isset($dia_inativo["deleted"]) && $dia_inativo["deleted"]) {
                    $diaDel = DiaInativoLocalReservavel::find($dia_inativo["id"]);
                    $diaDel->delete();
                }
            }

            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));

        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }


}