<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class LocalReservavel extends Model
{
    protected $connection = 'mysql';
    protected $table = 'local_reservavel';
    protected $fillable = [
        'id_localidade',
        'nome',
        'descricao',
        'capacidade',
        'regra_local',
        'foto_local',
        'visualizar_reversa_usuario',
        'antecedencia_max_num',
        'antecedencia_max_periodo',
        'antecedencia_min_num',
        'antecedencia_min_periodo',
        'antecedencia_cancel_num',
        'antecedencia_cancel_periodo',
        'limit_reserva',
        'restricao'
    ];

    public static function simples()
    {
        return self::with('localidade')->select(array('id', 'nome', 'descricao', 'id_localidade', 'capacidade', 'restricao'))
            ->orderBy('id','desc')
            ->get();
    }

    public static function complete($id)
    {
        return self::where('id', $id)->with(['localidade','periodo'])
            ->with(['diaInativo' => function($q) {
                $q->select('id','id_local_reservavel','descricao','repetir',\DB::raw("date_format(data,'%d/%m/%Y') as data"));
            }])
            ->first();
    }

    public static function nomeLocalReservavel($nome_local)
    {
        return self::with('localidade')->select(array('id', 'nome', 'descricao', 'id_localidade', 'capacidade'))
            ->where('nome','like','%'.$nome_local.'%')
            ->orderBy('id','desc')
            ->get();
    }

    ## Relacionamentos Entidades

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localidade');
    }

    public function periodo()
    {
        return $this->hasMany('App\Models\Reservas\PeriodoLocalReservavel','id_local_reservavel');
    }

    public function diaInativo()
    {
        return $this->hasMany('App\Models\Reservas\DiaInativoLocalReservavel','id_local_reservavel');
    }
}