<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ItemFornecedorPedido extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idfornecedorpedido',
        'iditem',
        'quantidadeFornecedor',
        'valorUnitarioFornecedor',
        'valorTotal'
    ];
}
