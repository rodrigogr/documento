<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoLancamento extends Model
{
    protected $connection = 'portaria';
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idgrupo_lancamento',
        'descricao',
        'fluxo'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function grupo_lancamento()
    {
        return $this->belongsTo('App\Models\GrupoLancamento', 'idgrupo_lancamento');
    }

    // ************************** hasMany ****************************
    public function pre_lancamentos()
    {
        return $this->hasMany('App\Models\PreLancamento', 'idtipo_lancamento');
    }

    public function lancamento_recorrentes()
    {
        return $this->hasMany('App\Models\LancamentoRecorrente', 'idtipo_lancamento');
    }

    public function lancamentos_by_tipo_lancamento()
    {
        return $this->hasMany('App\Models\LancamentoAgendar','id_tipo_lancamento');
    }
}
