<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Baixa extends Model
{
    static public $associations = [
    ];
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idrecebimento',
        'valor_pago',
        'valor_adicional',
        'data_pagamento',
        'data_compensacao',
        'observacao'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function recebimento()
    {
        return $this->belongsTo('App\Models\Recebimentos', 'idrecebimento');
    }
}
