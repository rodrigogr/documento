<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ItemFornecedorPedido extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'idfornecedorpedido',
        'iditem',
        'quantidadeFornecedor',
        'valorUnitarioFornecedor',
        'valorTotal'
    ];
}
