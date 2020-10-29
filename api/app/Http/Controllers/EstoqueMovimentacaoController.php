<?php

namespace App\Http\Controllers;

use App\Models\EstoqueMovimentacao;
use App\Models\EstoqueMovimentacaoProduto;
use Illuminate\Http\Request;

class EstoqueMovimentacaoController extends Controller
{
    private $name = 'Movimentacao';

    public function movimentacoes(){
        $data = EstoqueMovimentacao::paginate(10);
        foreach($data as $mov){
            $mov['estoque'] = EstoqueMovimentacaoProduto::where('id_estoque_movimentacao', $mov->id)->get();
            foreach($mov['estoque'] as $produto){
                $produto['vmDescricao'] = \App\Models\Produto::find($produto->id_produto)->descricao;            
            }
            if(isset($mov->id_fornecedor)) $mov['vmFornecedor'] = \App\Models\Empresa::find($mov->id_fornecedor)->nome_fantasia;
        }
        return response($data);
    }

    public function store(Request $request){
        try {
            \DB::beginTransaction();
            $data = $request->all();
            $estMov = new \App\Models\EstoqueMovimentacao();
            $estMov->createMov($data);
            \DB::commit();
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
    }

    public function delete($id){
        try {
            \DB::beginTransaction();
            $produtos = EstoqueMovimentacaoProduto::where('id_estoque_movimentacao', $id)->get();
            $Data = EstoqueMovimentacao::find($id);
            foreach($produtos as $produto) {
                $prd = \App\Models\Produto::find($produto['id_produto']);
                if($Data['tipo'] == 'entrada') $prd->quantidade_atual = $prd->quantidade_atual - $produto['quantidade'];
                else $prd->quantidade_atual = $prd->quantidade_atual + $produto['quantidade'];
                $produto['estoque_atual'] = $prd->quantidade_atual;
                $prd->save();
            }
            EstoqueMovimentacaoProduto::where('id_estoque_movimentacao', $id)->delete();
            $Data->delete();
            \DB::commit();
            return response('ok');
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
    }
}