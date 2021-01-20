<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class PeriodoLocalReservavel extends Model
{
    protected $connection = 'portal';
    protected $table = 'periodo_local_reservavel';
    public $timestamps = false;
    protected $fillable = [
        'id_local_reservavel',
        'dia_semana',
        'hora_ini',
        'hora_fim',
        'valor'
    ];

}