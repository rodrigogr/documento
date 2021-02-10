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

    public static function completoByData($data)
    {
        return self::leftJoin('reserva as r', function ($q) use($data) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
        })
            ->with(['imovel','pessoa','localReservavel','localidade'])
            ->where('periodo_local_reservavel.dia_semana','seg')
            ->orderBy('periodo_local_reservavel.hora_ini')
            ->get();
    }

    public static function completoByDataLocalReservavel($data, $id_local_reservavel)
    {
        return self::leftJoin('reserva as r', function ($q) use($data) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
        })
            ->with(['imovel','pessoa','localReservavel','localidade'])
            ->where('local_reservavel.id',$id_local_reservavel)
            ->orderBy('periodo_local_reservavel.hora_ini')
            ->get();
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }

    public function pessoa()
    {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa');
    }

    public function localReservavel()
    {
        return $this->belongsTo('App\Models\Reservas\LocalReservavel', 'id_local_reservavel');
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localidade');
    }

}