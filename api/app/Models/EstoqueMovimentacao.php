<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EstoqueMovimentacao extends Model
{
    protected $table = 'estoque_movimentacao';
    use SoftDeletes;
    public $timestamps = true;
    protected $fillable = [
        'operacao',
        'observacao',
        'tipo',
        'numero_nota',
        'valor_nota',
        'id_fornecedor',
        'valor_itens',
        'id_pedido'
    ];

    public function createMov($data){
        $Data = EstoqueMovimentacao::create($data);
        foreach($data['estoque'] as $produto){
            $prd = \App\Models\Produto::find($produto['id_produto']);
            if($Data->tipo == 'entrada') {
                $prd->quantidade_atual = $prd->quantidade_atual + $produto['quantidade'];
            } else {
                $prd->quantidade_atual = $prd->quantidade_atual - $produto['quantidade'];
            }
            $produto['estoque_atual'] = $prd->quantidade_atual;
            $prd->save();
            $produto['id_estoque_movimentacao'] = $Data->id;
            EstoqueMovimentacaoProduto::create($produto);
        }
    }
}