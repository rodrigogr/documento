<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class ParcelaPagar extends Model
{
    static public $associations = [
        'lancamento_agendar'
    ];
    public $timestamps = true;
    protected $table = 'parcela_pagar';
    protected $fillable = [
        'data_base',
        'id_conta_bancaria',
        'valor_pago',
        'tipo_operacao',
        'forma_pagamento',
        'id_lancamento_agendar',
        'data_pagamento',
        'data_compensacao',
        'valor_abatimento',
        'numero_comprovante',
        'forma_pagamento_origem'
    ] ;

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function getValorPagoAttribute($value)
    {
        return $value;
    }

    public function setValorPagoAttribute($value)
    {
        return $this->attributes['valor_pago'] = $value;
    }

    public function setDataBaseAttribute($value)
    {
        return $this->attributes['data_base'] = DataHelper::setDate($value);
    }

    public function getDataBaseAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDataPagamentoAttribute($value)
    {
        return $this->attributes['data_pagamento'] = DataHelper::setDate($value);
    }

    public function getDataPagamentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDataCompensacaoAttribute($value)
    {
        return $this->attributes['data_compensacao'] = DataHelper::setDate($value);
    }

    public function getDataCompensacaoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function lancamento_agendar()
    {
        return $this->belongsTo('App\Models\LancamentoAgendar', 'id_lancamento_agendar');
    }
}
