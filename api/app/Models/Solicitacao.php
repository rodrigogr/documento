<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Solicitacao extends Model
{
    public $table = 'solicitacoes';
    public $timestamps = true;
    protected $fillable = [
        'requerente',
        'departamento',
        'id_pedido',
        'status'
    ];

    public function pedidos()
    {
        return $this->hasOne('App\Models\Pedido','id_solicitacao','id');
    }
}
