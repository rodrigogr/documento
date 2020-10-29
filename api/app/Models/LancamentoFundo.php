<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LancamentoFundo extends Model
{
    protected $table = 'lancamento_fundo';
    protected $primaryKey = 'id_lancamento';
    protected $fillable = [
        'id_lancamento',
        'id_receita_calculos',
        'id_imovel'
    ];

    public function receita_calculo()
    {
        return $this->belongsTo('App\Models\ReceitaCalculo', 'id_receita_calculos');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }
    // ************************** hasOne ****************************
    public function lancamento()
    {
        return $this->hasOne('App\Models\Lancamento','id_lancamento');
    }

}
