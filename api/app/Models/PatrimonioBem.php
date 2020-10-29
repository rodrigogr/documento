<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PatrimonioBem extends Model
{
    public $timestamps = false;
    protected $table = 'patrimonios';
    protected $fillable = [
        'id_produto', 'numero', 'serie', 'descricao_garantia', 'fim_garantia', 'tipo_lancamento', 'tipo_incorporacao', 'data_incorporacao', 'data_compra', 'valor', 'id_centro_custo', 'id_empresa', 'numero_nota_fiscal', 'id_departamento', 'observacoes'
    ];

    public function departamento()
    {
        return $this->belongsTo('App\Models\Departamento', 'id_departamento');
    }

    public function produto()
    {
        return $this->belongsTo('App\Models\Produto', 'id_produto') ;
    }

    public function historico()
    {
        return $this->hasMany('App\Models\PatrimonioHistorico', 'id_patrimonio','id') ;
    }

    public function createBemPedido($data) {
        foreach($data['patrimonio'] as $produto){
            for ($i = 1; $i <= $produto['quantidade']; $i++){
                $prd = \App\Models\Produto::find($produto['id_produto']);
                $produto['estoque_atual'] = $prd->quantidade_atual + 1;
                $prd->save();
                $patrimonio = new PatrimonioBem();
                $patrimonio['id_produto'] = $produto['id_produto'];
                $patrimonio['id_departamento'] = $produto['id_departamento'];
                $patrimonio['tipo_lancamento'] = 'compras';
                $patrimonio['tipo_incorporacao'] = 'aquisição'; 
                $patrimonio['data_compra'] = $data['data_compra']; 
                $patrimonio['id_empresa'] = $data['id_fornecedor'];
                $patrimonio['numero_nota_fiscal'] = $data['numero_nota'];
                $patrimonio['data_incorporacao'] = date("Y-m-d");
                $patrimonio['valor'] = $produto['valorUnitarioFornecedor'];
                $patrimonio->save();
                $htPatr = new \App\Models\PatrimonioHistorico();
                $htPatr['id_patrimonio'] = $patrimonio['id'];
                $htPatr['status'] = 'PENDENTE';
                $htPatr['id_usuario'] = 1;// TODO: buscar o usuário logado.
                $htPatr['data_hora'] = date("Y-m-d");
                $htPatr->save();
            }
        }
    }
}