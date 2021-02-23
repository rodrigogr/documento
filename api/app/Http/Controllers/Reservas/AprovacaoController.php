<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;
use App\Services\Reservas\ReservaService;

class AprovacaoController extends Controller
{
    private $name = 'Aprovação';

    public function hoje()
    {
        $hoje = date('Y-m-d');
        $dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacaoPendenteHoje($hoje, $dia_semana);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }
}