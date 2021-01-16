<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class LocalReservavel extends Model
{
    protected $connection = 'portal';
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
        'limit_reserva'
    ];

    public static function complete()
    {
        return self::with(['localidade','periodo'])->get();
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localidade');
    }

    public function periodo()
    {
        return $this->hasMany('App\Models\Reservas\PeriodoLocalReservavel','id_reserva');
    }
}