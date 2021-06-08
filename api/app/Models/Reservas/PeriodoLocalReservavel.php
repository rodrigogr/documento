<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PeriodoLocalReservavel extends Model
{
    use SoftDeletes;
    protected $table = 'periodo_local_reservavel';
    public $timestamps = false;
    protected $fillable = [
        'id_local_reservavel',
        'dia_semana',
        'hora_ini',
        'hora_fim',
        'valor'
    ];

    public static function completoByData($data, $dia_semana)
    {
        return self::leftJoin('reserva as r', function ($q) use($data) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
        })
            ->with(['imovel','pessoa','localReservavel','diaInativo'])
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

    public static function completoByDataLocalReservavel($data, $id_local_reservavel, $dia_semana)
    {
        return self::leftJoin('reserva as r', function ($q) use($data, $id_local_reservavel) {
            $q->on('r.data',\DB::raw("'".$data."'"));
            $q->on('r.id_periodo','periodo_local_reservavel.id');
            $q->on('r.id_local_reservavel', \DB::raw($id_local_reservavel));
        })
            ->with(['imovel','pessoa','localReservavel','diaInativo'])
            ->where('periodo_local_reservavel.id_local_reservavel', $id_local_reservavel)
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

    public static function horariosReservasDoDia($data, $idLocalReservavel, $diaSemana)
    {
        return self::where('id_local_reservavel', $idLocalReservavel)
            ->where('dia_semana', $diaSemana)
            ->with(['reserva' => function ($q) {
                $q->select('id','status','id_periodo','id_pessoa','id_imovel');
                $q->with(['pessoa' => function($q) {
                    $q->select('id','nome','url_foto');
                }]);
                $q->with(['imovel' => function($q) {
                    $q->join('localidades as lo', 'lo.id', 'imovel.idLocalidade');
                    $q->select('imovel.id','imovel.quadra','imovel.lote','imovel.logradouro','lo.descricao');
                }]);
            }])
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

    public function reserva()
    {
        return $this->hasMany('App\Models\Reservas\Reserva','id_periodo','id');
    }

}