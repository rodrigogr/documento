<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EstoqueMovimentacaoProduto extends Model
{
    protected  $table = 'estoque_movimentacao_produto';
    use SoftDeletes;
    public $timestamps = true;
    protected $fillable = [
        'estoque_atual',
        'quantidade',
        'valor_unitario',
        'id_estoque_movimentacao',
        'id_produto'
    ];
}
