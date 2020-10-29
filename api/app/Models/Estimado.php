<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Estimado extends Model
{
    public $timestamps = true;

    static public $associations = [
        'tipo_lancamento',
        'grupo_lancamento'
    ];

    protected $fillable = [
        'mes_competencia',
        'ano_competencia',
        'id_tipolancamento',
        'id_grupolancamento',
        'valor',
        'fundo_reserva'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasOne ****************************
    public function tipo_lancamento()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamento');
    }

    public function grupo_lancamento()
    {
        return $this->belongsTo('App\Models\GrupoLancamento', 'id_grupolancamento');
    }

    public function lancamento_pagar()
    {
        return $this->hasMany('App\Models\LancamentoAgendar','id_tipo_lancamento','id_tipolancamento');
    }
}
