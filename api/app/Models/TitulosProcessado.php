<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class TitulosProcessado extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'id_arquivo_retorno',
        'status',
        'nosso_numero',
        'numero_documento',
        'numero_controle',
        'ocorrencia',
        'ocorrencia_tipo',
        'desc_ocorrencia',
        'dt_ocorrencia',
        'dt_vencimento',
        'dt_credito',
        'valor',
        'valor_tarifa',
        'valor_iof',
        'valor_abatimento',
        'valor_desconto',
        'valor_recebido',
        'valor_mora',
        'valor_multa',
        'recebimento',
        'error',
        'valor_total_calculado',
        'valor_juros_calculado',
        'valor_multa_calculado',
        'dt_pagamento'

    ];

    public function arquivo_retorno()
    {
        return $this->belongsTo('App\Models\ArquivoRetorno','id_arquivo_retorno');
    }

    public function setDtOcorrenciaAttribute($value)
    {
        return $this->attributes['dt_ocorrencia'] = DataHelper::setDate($value);
    }

    public function getDtOcorrenciaAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDtCreditoAttribute($value)
    {
        return $this->attributes['dt_credito'] = DataHelper::setDate($value);
    }

    public function getDtCreditoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDtPagamentoAttribute($value)
    {
        return $this->attributes['dt_pagamento'] = DataHelper::setDate($value);
    }

    public function getDtPagamentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
}
