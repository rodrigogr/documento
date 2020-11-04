<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Produto extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'idunidade_produto',
        'idgrupo_produto',
        'referencia',
        'descricao',
        'quantidade_minima',
        'quantidade_maxima',
        'quantidade_atual',
        'origem',
        'tipo',
        'status',
        'idarea',
        'idcolunas',
        'idniveis',
        'idsequencia',
        'idrua',
        'observacoes'
    ];

    public function unidade_produto()
    {
        return $this->belongsTo('App\Models\UnidadeProduto', 'idunidade_produto');
    }

    public function grupo_produto()
    {
        return $this->belongsTo('App\Models\GrupoProduto', 'idgrupo_produto');
    }

    public function item_produto()
    {
        return $this->belongsTo('App\Models\ItemPedido', 'idproduto');
    }
}
