<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\ReservaRequest;
use App\Models\Reservas\LocalReservavel;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;
use App\Services\Reservas\ReservaService;
use Illuminate\Http\Request;

class ReservaController extends Controller
{
    private $name = 'Reserva';

    public function index()
    {
        $Data = Reserva::allCompleto();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(Request $request)
    {
        try {
            foreach ($request->all() as $item) {

                $check = Reserva::verificaReserva($item["id_periodo"], $item["data"]);
                usleep(25000);

                if (count($check) && $check[0]["status"] != "recusado") {
                    return response()->error("Erro! Este período já reservado!");
                } else {
                    Reserva::create($item);
                }
            }

            return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));

        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.FSE', ['name' => $this->name]));
        }
    }

    public function show($id)
    {
        $Data = Reserva::simples($id);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    public function completoByData($data)
    {
        $dia_semana = ReservaService::diaSemana($data);
        $Data = PeriodoLocalReservavel::completoByData($data, $dia_semana);

        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FGAE', ['name' => $this->name]).' nesta data.');
    }

    public function completoByDataLocalReservavel($data, $id_local_reservavel)
    {
        $dia_semana = ReservaService::diaSemana($data);
        $Data = PeriodoLocalReservavel::completoByDataLocalReservavel($data, $id_local_reservavel, $dia_semana);

        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FGAE', ['name' => $this->name]));
    }

    public function completoByImovel($idImovel)
    {
        $Data = Reserva::completoByImovel($idImovel);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function completoByStatus($status)
    {
        $Data = Reserva::completoByStatus($status);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function completoById($id)
    {
        $Data = Reserva::completoById($id);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function updateStatus($id, ReservaRequest $request )
    {
        $data = $request->all();
        $reserva = Reserva::find($id);
        $reserva->status = $data["status"];
        $reserva->save();

        if ($reserva) {
            return response()->success($reserva);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
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

    public function cancelar(Request $reservas_cancelar)
    {
        try {
            foreach ($reservas_cancelar->all() as $reserva) {
                $data = Reserva::find($reserva['id']);
                $data->delete();
            }

            return response()->success(trans('messages.crud.FCS', ['name' => $this->name]));
        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.FCE', ['name' => $this->name]));
        }
    }

    public function eventosCalendario(Request $request)
    {
        $req = $request->all();
        $reqStart = explode("T", $req["start"])[0];
        $reqEnd = explode("T", $req["end"])[0];

        $dados = Reserva::getEventosCalendario($reqStart, $reqEnd, $req["id_local"]);

        return response()->success($dados);
        /*try {
            foreach ($filtros->all() as $reserva) {
                $data = Reserva::find($reserva['id']);
                $data->delete();
            }

            return response()->success(trans('messages.crud.FCS', ['name' => $this->name]));
        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.FCE', ['name' => $this->name]));
        }*/
    }

    public function dataLocalReservavel($data, $idLocalReservavel, $idPessoa, $idImovel)
    {
        $diaSemana = ReservaService::diaSemana($data);
        $configLocal = LocalReservavel::localReservavelById($idLocalReservavel);
        $reservasHorariosDoDia["periodo"] = PeriodoLocalReservavel::horariosReservasDoDia($data, $idLocalReservavel, $diaSemana);

        $total_res_pessoa = 0;
        $total_res_imovel = 0;
        foreach ($reservasHorariosDoDia["periodo"] as $re) {
            $re["total_reservado_periodo"] = count($re["reserva"]);
            $re["resta_limite_reserva"] = $configLocal[0]["limit_reserva_periodo"] - $re["total_reservado_periodo"];

            foreach ($re["reserva"] as $key => $item) {
                if ($re["reserva"][$key]["id_pessoa"] == $idPessoa) {
                    $total_res_pessoa++;
                }
                if ($re["reserva"][$key]["id_imovel"] == $idImovel) {
                    $total_res_imovel++;
                }
            }
        }
        $reservasHorariosDoDia["total_reservado_usuario_dia"] = $total_res_pessoa;
        $reservasHorariosDoDia["total_reservado_imovel_dia"] = $total_res_imovel;

        return response()->success($reservasHorariosDoDia);
    }

    public function historicoUsuario($idUsuario, $idImovel)
    {
        $Data = Reserva::historicoUsuario($idUsuario, $idImovel);
        return response()->success($Data);
    }

}