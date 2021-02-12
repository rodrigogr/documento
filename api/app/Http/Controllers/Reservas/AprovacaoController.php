<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Models\Reservas\Reserva;

class AprovacaoController extends Controller
{
    private $name = 'Aprovação';

    public function hoje()
    {
        $Data = Reserva::aprovacaoPendente();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }
}