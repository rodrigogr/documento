<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AcrescimoPagar extends Model
{
    public $timestamps = true;
    protected  $table = 'acrescimo_pagar';

    protected $fillable = [
        'id_lancamento_agendar',
        'id_tipo_lancamento',
        'valor',
        'incluir_soma'
    ];

    public function tipo_lancamento()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipo_lancamento');
    }

    public function lancamento_agendar()
    {
        return $this->belongsTo('App\Models\LancamentoAgendar', 'id_lancamento_agendar');
    }
}
