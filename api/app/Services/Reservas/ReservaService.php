<?php
namespace App\Services\Reservas;

class ReservaService
{
    public static function diaSemana($data)
    {
        $semana = array('dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab');
        $data = date($data);
        $dia_semana_numero = date('w', strtotime($data));

        return $semana[$dia_semana_numero];
    }
}