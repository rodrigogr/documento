<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class PeriodoLocalReservavel extends Model
{
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
        return self::leftJoin('reserva as r', function ($q) use($data, $id_local_reservavel) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
            $q->on('r.id_local_reservavel', \DB::raw($id_local_reservavel));
        })
            ->with(['imovel','pessoa','localReservavel','diaInativo'])
            ->where('periodo_local_reservavel.id_local_reservavel', $id_local_reservavel)
            ->orderBy('periodo_local_reservavel.hora_ini')
            ->select('periodo_local_reservavel.*', 'r.id_imovel as reserva_idImovel', 'r.id_pessoa as reserva_idPessoa', 'r.status as reserva_status')
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

    public function diaInativo()
    {
        return $this->hasMany('App\Models\Reservas\DiaInativoLocalReservavel','id_local_reservavel','id_local_reservavel');
    }

}