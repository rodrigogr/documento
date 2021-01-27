<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\ReservaRequest;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;

class ReservaController extends Controller
{
    private $name = 'Reserva';

    public function index()
    {
        $Data = Reserva::simples();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(ReservaRequest $request)
    {
        try {
            $data = $request->all();
            $reserva = Reserva::create($data);

            return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));

        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.FSE', ['name' => $this->name]));
        }
    }

    public function show($id)
    {
        $Data = Reserva::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    public function completoByData($data)
    {
        $Data = PeriodoLocalReservavel::completoByData($data);
//        $Data = Reserva::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FSE', ['name' => $this->name]));
    }

    public function update(ReservaRequest $request, $id)
    {
        $data = $request->all();

        foreach ($data["periodo"] as $key => $dia_semana) {
            foreach ($dia_semana as $dados_dia) {
                if (!isset($dados_dia["id"]) && $dados_dia["hora_ini"]) {
                    $dados_dia["id_local_reservavel"] = $id;
                    $dados_dia["dia_semana"] = $key;
                    PeriodoReserva::insert($dados_dia);
                }
                if (isset($dados_dia["id"]) && $dados_dia["hora_ini"] && (isset($dados_dia["deleted"]) && !$dados_dia["deleted"])) {
                    $periodoAlt = PeriodoReserva::find($dados_dia["id"]);
                    $periodoAlt->id_local_reservavel = $id;
                    $periodoAlt->dia_semana = $key;
                    $periodoAlt->hora_ini = $dados_dia["hora_ini"];
                    $periodoAlt->hora_fim = $dados_dia["hora_fim"];
                    $periodoAlt->valor = $dados_dia["valor"];
                    $periodoAlt->save();
                }
                if (isset($dados_dia["deleted"]) && $dados_dia["deleted"]) {
                    $periodoDel = PeriodoReserva::find($dados_dia["id"]);
                    $periodoDel->delete();
                }
            }
        }

        foreach ($data["diasInativos"] as $dia_inativo) {
            if (!isset($dia_inativo["id"])) {
                $dia_inativo["id_local_reservavel"] = $id;
                unset($dia_inativo['deleted']);
                DiaInativoReserva::insert($dia_inativo);
            }
            if (isset($dia_inativo["id"]) && !$dia_inativo["deleted"]) {
                $diaAlt = DiaInativoReserva::find($dia_inativo["id"]);
                $diaAlt->id_local_reservavel = $id;
                $diaAlt->data = $dia_inativo["data"];
                $diaAlt->descricao = $dia_inativo["descricao"];
                $diaAlt->repetir = $dia_inativo["repetir"];
                $diaAlt->save();
            }
            if (isset($dia_inativo["deleted"]) && $dia_inativo["deleted"]) {
                $diaDel = DiaInativoReserva::find($dia_inativo["id"]);
                $diaDel->delete();
            }
        }

        return 'ok';
    }

    public function cancelar($id)
    {
        try {
            $data = Reserva::find($id);
            $data->delete();
            return response()->success(trans('messages.crud.FCS', ['name' => $this->name]));
        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.FCE', ['name' => $this->name]));
        }
    }

}