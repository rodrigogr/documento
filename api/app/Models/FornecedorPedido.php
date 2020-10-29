<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FornecedorPedido extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idpedido',
        'idfornecedor',
        'valorTotal',
        'valorTotalCalculado',
        'acrescimo',
        'desconto',
        'status',
        'observacao'
    ];

    public function empresa()
    {
        return $this->hasOne('App\Models\Empresa','id','idfornecedor');
    }
}
