<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;

class Reserva extends Model
{
    protected $connection = 'portal';
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

        //RETORNAR ESTE SQL
        /*select
        	plr.dia_semana ,
        	plr.hora_ini,
        	r.*
        from
        	periodo_local_reservavel plr
        	left join reserva r on r.id_periodo = plr.id
        		and r.`data` ='2021-01-30'
        where
        	plr.dia_semana = 'seg'*/

        /*return self::where('data', $data)->with(['periodoLocalReservavel' => function($query) {
            $query->select('id','hora_ini','hora_fim')->orderBy('hora_ini','desc');
        }])->get();*/
        //return self::where('data', $data)->with(['localReservavel','periodoLocalReservavel','imovel', 'pessoa'])->get();
        //->get()->sortBy('periodo_local_reservavel.hora_ini',SORT_REGULAR,true);
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
}