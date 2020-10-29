<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    static public $associations = [
        'itemsPedido',
        'fornecedores'
    ];
    public $timestamps = true;
    protected $fillable = [
        'requerente',
        'descricao',
        'departamento',
        'expectativa_entrega',
        'expectativa_valor',
        'solicitado_id',
        'status',
        'id_lancamento_agendar',
        'movimentado',
        'solicitacao',
        'motivo_negado'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function fornecedores()
    {
        return $this->hasMany('App\Models\FornecedorPedido', 'idpedido');
    }

    public function itemsPedido()
    {
        return $this->hasMany('App\Models\ItemPedido', 'idpedido');//->hasOne('App\Models\Produto', 'idproduto');
    }

}
