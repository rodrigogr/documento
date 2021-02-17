<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;

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

    public static function simples()
    {
        return self::with('localidade')->select(array('id', 'nome', 'descricao', 'id_localidade', 'capacidade'))->get();
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
            $q->where('r.status','=','pendente');
        })
            ->with(['imovel','pessoa','localReservavel','diaInativo'])
            ->where('periodo_local_reservavel.dia_semana', $dia_semana)
            ->orderBy('periodo_local_reservavel.hora_ini')
            ->select('periodo_local_reservavel.*', 'r.id_imovel as reserva_idImovel',
                'r.id_pessoa as reserva_idPessoa',
                'r.status as reserva_status',
                'r.id_imovel',
                'r.id_pessoa')
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
}