<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;
use App\Services\Reservas\ReservaService;
use Illuminate\Http\Request;
use mysql_xdevapi\Exception;

class AprovacaoController extends Controller
{
    private $name = 'Aprovação';

    public function pendentesHoje()
    {
        $hoje = date('Y-m-d');
        //$dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacoes($hoje);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function pendentesHojeLocalReservavel($local)
    {
        $hoje = date('Y-m-d');
        //$dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacoes($hoje, $local);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function pendentesHojeLocalidade($localidade)
    {
        $hoje = date('Y-m-d');
        //$dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacoes($hoje,false, $localidade);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function aprovacao($id, Request $request)
    {
        try {
            $reserva = Reserva::find($id);
            $reserva->status = 'aprovada';
            $reserva->update();
            return response()->success(trans('messages.crud.MUS', ['name' => 'Reserva']));

        } catch(\Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function recusar(Request $request)
    {
        $usuario = \Auth::user();

        try {
            $Data = $request->all();
            $reserva = Reserva::find($Data["id"]);
            $reserva->status = 'recusado';
            $reserva->obs = $Data["motivo"];
            $reserva->autor = $usuario->id_pessoa_bioacesso;
            $reserva->update();
            return response()->success(trans('messages.crud.FUS', ['name' => 'Reserva ']));

        } catch(\Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function recusados($data)
    {
        if ($data == 'todos') {
            $Data = Reserva::aprovacoes($data,'','','recusado');
        } else {
            //$dia_semana = ReservaService::diaSemana($data);
            $Data = Reserva::aprovacoes($data);
        }

        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }
}