<?php

namespace App\Models;

use  App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RecebimentoParcela extends Model
{
    use SoftDeletes;
    public $timestamps =true;
    protected $fillable = [
        'valor',
        'valor_origem',
        'id_recebimento',
        'valor_recebido',
        'valor_multa',
        'valor_juros',
        'forma_pagamento',
        'data_compensado',
        'data_recebimento',
        'taxa_adicional',
        'observacao',
        'id_situacao_inadimplencia'
    ];

    protected $dates = ['deleted_at'];

    public function setDataCompensadoAttribute($value)
    {
        return $this->attributes['data_compensado'] = DataHelper::setDate($value);
    }

    public function getDataCompensadoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    public function setDataRecebimentoAttribute($value)
    {
        return $this->attributes['data_recebimento'] = DataHelper::setDate($value);
    }

    public function getDataRecebimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    public function parcelasBoleto()
    {
        return $this->hasOne('App\Models\ParcelaBoleto', 'id_parcela');
    }

    public function recebimento()
    {
        return $this->belongsTo('App\Models\Recebimento','id_recebimento');
    }

    public function situacaoInadimplencia()
    {
        return $this->belongsTo('App\Models\SituacaoInadimplencia','id_situacao_inadimplencia');
    }

    public function parcelasAcordo()
    {
        return $this->hasOne('App\Models\Acordo','id_recebimento','id_recebimento');
    }
}
