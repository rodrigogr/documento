<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class PeriodoLocalReservavel extends Model
{
    protected $connection = 'portal';
    protected $table = 'periodo_local_reservavel as plr';
    public $timestamps = false;
    protected $fillable = [
        'id_local_reservavel',
        'dia_semana',
        'hora_ini',
        'hora_fim',
        'valor'
    ];

    public static function completoByData($data)
    {
        return self::leftJoin('reserva as r', function ($q) use($data) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','plr.id');
        })
            ->where('plr.dia_semana','seg')
            ->orderBy('plr.hora_ini')
            ->get();
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }

}