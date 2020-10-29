<?php

namespace App\Models;

use App\Helpers\DataHelper;

class ParcelaBoleto extends RecebimentoParcela
{
    public $timestamps = false;
    protected $fillable = [
        'id_parcela',
        'data_vencimento',
        'data_vencimento_origem',
        'percentualmulta',
        'percentualjuros',
        'juros_apos',
        'dias_protesto',
        'nosso_numero',
        'numero_documento',
        'situacao',
        'agrupado',
        'aceite',
        'especie_doc',
        'file_remessa',
        'numero_controler',
        'nosso_numero_boleto',
        'status',
        'nosso_numero_origem'
    ];

    protected $primaryKey = 'id_parcela';
    protected $dates = ['deleted_at'];

    public function setDataVencimentoAttribute($value)
    {
        return $this->attributes['data_vencimento'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    public function setDataVencimentoOrigemAttribute($value)
    {
        return $this->attributes['data_vencimento_origem'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoOrigemAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }


    static public $associations = [
        'parcela'
    ];
    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id_parcela', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function parcela()
    {
        return $this->belongsTo('App\Models\RecebimentoParcela', 'id_parcela');
    }

}
