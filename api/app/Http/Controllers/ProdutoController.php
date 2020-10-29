<?php

namespace App\Http\Controllers;

use App\Models\GrupoProduto;
use App\Models\ImagemProduto;
use App\Models\UnidadeProduto;
use Illuminate\Database\QueryException;
use Storage;
use App\Models\Produto;
use App\Http\Requests\ProdutoRequest;
use Illuminate\Http\Request;
use finfo;
use Intervention\Image\ImageManagerStatic as Image;

class ProdutoController extends Controller
{
    private $name = 'Produto';

    public function index(Request $request)
    {
        $data = $request->all();
        if(isset($data['page'])){
            $Data = Produto::with(['grupo_produto', 'unidade_produto'])->orderBy('id','DESC')->paginate(10);
            foreach($Data->items() as $data){
                $data['imagens'] = ImagemProduto::where('idprodutos', '=', $data->id)->get()->map(function($value){return $value->id;});
            }
            return response($Data);
        }
        $Data = Produto::with(['grupo_produto'])->get();
        $result = array();
        foreach ( $Data as $produto ) {
            $unidade = UnidadeProduto::where("id","=",$produto->idunidade_produto)->first(['id', 'descricao']);
            $grupo = GrupoProduto::where("id","=",$produto->idgrupo_produto)->first(['id', 'descricao','status']);
            $imagens = ImagemProduto::where('idprodutos', '=', $produto->id)->get(['id', 'imagem']);
            foreach($imagens as $value) {
                $storage = "'" . Storage::disk('public')->url("produtos/" . $value["imagem"]) . "'";
                $path = $storage ;
                $value["imagem"] = $path;
            }
            $result[] = array("produto" => $produto, "unidade"=> $unidade, "grupo"=> $grupo,"imagens"=>$imagens);
        }
        return response()->success($result);
    }

    public function store(ProdutoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Produto::create($data);
            return response($Data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function show($id)
    {
        $Data = Produto::find($id);
        $Data['imagens'] = \App\Models\ImagemProduto::where('idprodutos', '=', $id)->get()->map(function($value){return $value->id;});
        return response()->success($Data);
    }

    public function update(ProdutoRequest $request, $id)
    {
        $Data = Produto::find($id);
        $produto = \App\Models\ItemPedido::where('idproduto',$id)->value('id');
        if (count($Data)) {
            try {
                $data = $request->all();
                if($Data->status == "1" && $request->input("status") == "0")
                {
                    if($produto != null){
                        return response()->error("Não é Possivel inativar um produto relacionado a um pedido!");
                    }
                }
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id)
    {
        $Data = Produto::find($id);
        try {
            $Data->delete();
            return response('ok');
        } catch (QueryException $q){
            if($q->getCode()=="23000"){
                return response()->error(array("erro" => "Este registro não pode ser excluido. Há registro(s) de informações associado(s) a ele."));
            } else {
                return response()->error($q->getMessage());
            }
        } catch (\Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function getProdAtivoConsumo()
    {
        $Data = Produto::where('status', 1)->where('tipo', 0)->get();
        return response($Data);
    }

    public function detail($id)
    {
        $produto = Produto::find($id);
        $return = [
            'id' => $produto['id'],
            'origem' => $produto['origem'],
            'tipo' => $produto['tipo'],
            'observacoes' => $produto['observacoes'],
            'status' => $produto['status'] ? 'ativo' : 'inativo',
            'referencia' => $produto['referencia'],
            'descricao' => $produto['descricao'],
            'qntAtual' => $produto['quantidade_atual'],
            'qntMin' => $produto['quantidade_minima'],
            'qntMax' => $produto['quantidade_maxima'],
            'area' => \App\Models\Area::find($produto['idarea'])['descricao'],
            'rua' => \App\Models\Rua::find($produto['idrua'])['descricao'],
            'coluna' => \App\Models\Coluna::find($produto['idcolunas'])['descricao'],
            'nivel' => \App\Models\Nivel::find($produto['idniveis'])['descricao'],
            'sequencia' => \App\Models\Sequencia::find($produto['idsequencia'])['descricao'],
            'grupo' => \App\Models\GrupoProduto::find($produto['idgrupo_produto'])['descricao'],
            'unidade' => \App\Models\UnidadeProduto::find($produto['idunidade_produto'])['descricao'],
            'imagens' => \App\Models\ImagemProduto::where('idprodutos', '=', $id)->get()->map(function($value){return $value->id;})
        ];
        return response()->success($return);
    }

    public function searchEstoque(Request $request){
        $search = $request->all();
        $Data = [];
        if(isset($search['term']) && $search['term'] != ''){
            $Data = Produto::where('descricao','LIKE', '%'.$search['term'].'%')->where('status', 1)->where('tipo', 0)->paginate(12);
        } else {
            $Data = Produto::where('status', 1)->where('tipo', 0)->paginate(12);
        }
        foreach ($Data as $produto){
            $produto['qntAtual']  = $produto['quantidade_atual'];
            $produto['qntMin']  = $produto['quantidade_minima'];
            $produto['qntMax']  = $produto['quantidade_maxima'];
            $produto['area']  = \App\Models\Area::find($produto['idarea'])['descricao'];
            $produto['rua']  = \App\Models\Rua::find($produto['idrua'])['descricao'];
            $produto['coluna']  = \App\Models\Coluna::find($produto['idcolunas'])['descricao'];
            $produto['nivel']  = \App\Models\Nivel::find($produto['idniveis'])['descricao'];
            $produto['sequencia']  = \App\Models\Sequencia::find($produto['idsequencia'])['descricao'];
        }
        return response($Data);
    }

    public function saveImage(Request $request){
        try {
            $data = $request->all();
            $Data = new \App\Models\ImagemProduto();
            if(isset($data['id'])) $Data = \App\Models\ImagemProduto::findOrFail($data['id']);
            $Data['imagem'] = $data['imagem'];
            $Data['idprodutos'] = $data['idprodutos'];
            $Data->save();
            return response('ok');
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function getImage64(Request $request, $id){
        try {
            $Data = \App\Models\ImagemProduto::find($id);
            return response($Data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function deleteImage($id){
        try {
            $Data = \App\Models\ImagemProduto::find($id);
            $Data->delete();
            return response('ok');
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function getBuscaProduto(Request $request)
    {
        $dados = $request->all();
        $produto = Produto::select('id','descricao','idunidade_produto','idgrupo_produto')->where('idgrupo_produto',$dados["t"]);
        if (isset($dados["q"])) {
            $produto = $produto->where('descricao','like','%'.$dados["q"].'%')
                ->with(['unidade_produto' => function($q) {
                    $q->select('id','descricao');
                }])
                ->with(['grupo_produto' => function($q) {
                    $q->select('id','descricao');
                }])
                ->take(30)
                ->get();
        } else {
            $produto = $produto->with(['unidade_produto' => function($q) {
                    $q->select('id','descricao');
                }])
                ->with(['grupo_produto' => function($q) {
                    $q->select('id','descricao');
                }])
                ->get();
        }

        return $produto;
    }
}