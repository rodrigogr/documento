<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\SoftDeletes;

class FluxoCaixa extends Model
{
    use SoftDeletes;
    public $timestamps = true;
    protected $table = 'fluxo_caixa';
    protected $dates = ['deleted_at'];
    protected $fillable = [
        'id_conta_bancaria',
        'id_parcela',
        'valor',
        'data_vencimento',
        'data_pagamento',
        'descricao',
        'referente',
        'tabela',
        'fluxo'
    ];

    public function getDataPagamentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDataPagamentoAttribute($value)
    {
        return $this->attributes['data_pagamento'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDataVencimentoAttribute($value)
    {
        return $this->attributes['data_vencimento'] = DataHelper::setDate($value);
    }

    public function contaBancaria()
    {
        return $this->belongsTo('App\Models\ContaBancaria','id_conta_bancaria');
    }
}
