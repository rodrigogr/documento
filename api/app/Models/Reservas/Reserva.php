<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;
use function foo\func;

class Reserva extends Model
{
    protected $table = 'reserva';
    protected $fillable = [
        'id_local_reservavel',
        'data',
        'id_periodo',
        'status',
        'id_imovel',
        'id_pessoa'
    ];
    public $timestamps = true;
    use SoftDeletes;

    public static function allCompleto()
    {
        return self::with(['localReservavel' => function ($q) {
            $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
            $q->select('localidades.descricao as localidade','local_reservavel.*');
        }])
            ->with(['periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->get();
    }

    public static function completoByData($data)
    {
        return self::where('data', $data)
            ->select('reserva.*')
            ->join('periodo_local_reservavel as plr','plr.id','reserva.id_periodo')
            ->with(['periodoLocalReservavel','localReservavel','imovel','pessoa'])
            ->orderBy('plr.hora_ini')
            ->get();
    }

    public static function aprovacaoPendenteHoje($hoje, $dia_semana)
    {
        return PeriodoLocalReservavel::join('reserva as r', function ($q) use($hoje) {
            $q->on('r.data',\DB::raw("'".$hoje."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
        })
            ->with(['imovel','pessoa','diaInativo'])
            ->with(['localReservavel' => function ($q) {
                $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
                $q->select('bioacesso_portaria.localidades.descricao as localidade','local_reservavel.*');
            }])
            ->where('periodo_local_reservavel.dia_semana', $dia_semana)
            ->orderBy('periodo_local_reservavel.hora_ini')
            ->select('periodo_local_reservavel.*',
                \DB::raw('date_format(periodo_local_reservavel.hora_ini,"%H:%i") as hora_ini'),
                \DB::raw('date_format(periodo_local_reservavel.hora_fim,"%H:%i") as hora_fim'),
                'r.id_imovel as reserva_idImovel',
                'r.id_pessoa as reserva_idPessoa',
                'r.status as reserva_status',
                'r.id_imovel',
                'r.id_pessoa')
            ->get();
    }

    public static function completoByImovel($idImovel)
    {
        return self::with(['localReservavel','periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->where('id_imovel', $idImovel)
            ->get();
    }

    public static function completoByStatus($status)
    {
        return self::with(['localReservavel','periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->where('status', $status)
            ->get();
    }

    public static function simples($id)
    {
        return self::where('id',$id)
            ->get();
    }

    public static function completoById($id)
    {
        return self::with(['localReservavel','periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->where('id', $id)
            ->get();
    }

    public function localReservavel()
    {
        return $this->belongsTo('App\Models\Reservas\LocalReservavel', 'id_local_reservavel');
    }

    public function periodoLocalReservavel()
    {
        return $this->belongsTo('App\Models\Reservas\PeriodoLocalReservavel', 'id_periodo');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }

    public function pessoa()
    {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa');
    }

    public function diaInativo()
    {
        return $this->hasMany('App\Models\Reservas\DiaInativoLocalReservavel','id_local_reservavel','id_local_reservavel');
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_pessoa');
    }
}