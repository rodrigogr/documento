<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class ReceitaCalculo extends Model
{
    protected $fillable = [
        'data_calculo',
        'data_vencimento',
        'total_despesas_apurada',
        'area_total_apurada',
        'total_imoveis',
        'fracao_ideal_rateio',
        'tipo_apuracao',
        'percentual_juros',
        'percentual_multa',
        'percentual_fundo_reserva',
        'termo_aprovacao'
    ];

    public function setDataVencimentoAttribute($value)
    {
        return $this->attributes['data_vencimento'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function getDataVencimento()
    {
        return $this->attributes['data_vencimento'];
    }

    public function setDataCalculoAttribute($value)
    {
        return $this->attributes['data_calculo'] = DataHelper::setDate($value);
    }

    public function getDataCalculoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function carteira()
    {
        return $this->hasOne('App\Models\ContaBancaria', 'id_carteira');
    }

    public function formulas ()
    {
        return $this->belongsToMany('App\Models\Formulas');
    }

    public function fundos()
    {
        return $this->hasMany('App\Models\ReceitaCalculoFundo', 'id_receita_calculos');
    }

    public function taxas()
    {
        return $this->hasMany('App\Models\ReceitaCalculoTaxa','id_receita_calculos');
    }
}
