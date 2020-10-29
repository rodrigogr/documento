<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ItemPedido extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'idpedido',
        'idproduto',
        'tipo_lancamento',
        'quantidade'
    ];

    public function produto()
    {
        return $this->hasOne('App\Models\Produto','id','idproduto');
    }

}