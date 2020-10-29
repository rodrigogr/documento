<?php

namespace App\Http\Controllers;

use App\Mail\SendMail;
use App\Models\Aprovador;
use App\Models\Condominio;
use App\Models\ItemPedido;
use App\Models\ParcelaBoleto;
use App\Models\Pedido;
use App\Models\Produto;
use App\Helpers\DataHelper;
use App\Http\Requests\PedidoRequest;
use App\Models\Usuario;
use App\PrintPdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Respect\Validation\Rules\Date;
use Tymon\JWTAuth\Facades\JWTAuth;

class PedidoController extends Controller
{
    private $name = 'Pedido';
    private $html_reset_css =
        '<style>html, body, div, span, applet, object, iframe,
        h1, h2, h3, h4, h5, h6, p, blockquote, pre,
        a, abbr, acronym, address, big, cite, code,
        del, dfn, em, img, ins, kbd, q, s, samp,
        small, strike, strong, sub, sup, tt, var,
        b, u, i, center,
        dl, dt, dd, ol, ul, li,
        fieldset, form, label, legend,
        table, caption, tbody, tfoot, thead, tr, th, td,
        article, aside, canvas, details, embed, 
        figure, figcaption, footer, header, hgroup, 
        menu, nav, output, ruby, section, summary,
        time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            vertical-align: baseline;
        }
        /* HTML5 display-role reset for older browsers */
        article, aside, details, figcaption, figure, 
        footer, header, hgroup, menu, nav, section {
            display: block;
        }
        body {
            line-height: 1;
        }
        ol, ul {
            list-style: none;
        }
        blockquote, q {
            quotes: none;
        }
        blockquote:before, blockquote:after,
        q:before, q:after {
            content: \'\';
            content: none;
        }
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }
        .solicitacao {
            margin-top: 20px;
            width: 100%;
        }
        .solicitacao tr {
            border: 1px solid #444444;
        }
        .solicitacao td {
            padding: 8px;
            border: 1px solid #444444;
        }
        .mapa-coleta-titulo {
            
            text-align:center;
            padding-bottom: 10px;
        }
        h2.mapa-coleta-titulo {
            font-size: 20px;
        }
        h3.mapa-coleta-titulo {
            font-size: 15px;
        }
        .head-item td {
            font-weight: bold;
            text-align: center;
        }
        .center {
            text-align: center;
        }
        .right {
            text-align: right;
        }
        .item-lista td span {
            text-align: right;
        }
        .item-lista .moeda {
            border-right: none;
            width: 1px;
        }
        .item-lista .valor {
            border-left: none;
            width: 1px;
        }
        </style>';

    public function index(Request $request)
    {
        $data = $request->all();

        if(isset($data['page'])) {
            $Data = \App\Models\Pedido::where('pedidos.status','!=','Solicitado')->orderBy('pedidos.created_at', 'desc');
            if(isset($data["descricao"])) {
                $Data = $Data->where('pedidos.descricao','like','%'.$data["descricao"].'%');
            }
            if(isset($data["status"]) && $data["status"] != 'todos') {
                $Data = $Data->where('pedidos.status',$data["status"]);
            }
            $empresa = isset($data["empresa"]) ? $data["empresa"] : false;
            $cnpj = isset($data["cnpj"]) ? $data["cnpj"] : false;
            if($empresa || $cnpj) {
                $Data = $Data->whereHas('fornecedores', function($q) use($empresa,$cnpj) {
                    $q->whereHas('empresa', function ($q) use ($empresa,$cnpj) {
                        if($empresa) {
                            $q->where('nome_fantasia', 'like', '%' . $empresa . '%');
                        }
                        if($cnpj) {
                            $cnpj = str_replace("/","" ,str_replace("-","" , str_replace(".","" , $cnpj)));
                            $q->whereRaw('"'.$cnpj.'" = trim(replace(replace(replace(cnpj,"/",""), ".", ""), "-", ""))');
                        }
                    });
                });
            }
            $Data = $Data->paginate(12);
            foreach ($Data->Items() as $value) {
                $itens = \App\Models\ItemPedido::with('produto:id,descricao')->where('idpedido', '=', $value->id)->get(['id', 'idpedido','idproduto','tipo_lancamento','quantidade']);
                $fornecedores = \App\Models\FornecedorPedido::with('empresa:id,nome_fantasia,cnpj')->where('idpedido', '=', $value->id)->get(['id', 'idpedido','idfornecedor','valorTotal','valorTotalCalculado','acrescimo','desconto','observacao','status']);
                $itensComDescricao = array();
                $qtd = 0;
                $resumoItens = "";
                $qtdProduto = 0;
                $qtdServico = 0;
                foreach ($itens as $valueItem) {
                    $produto = \App\Models\Produto::where('id', '=', $valueItem->idproduto)->first();
                    $unidade = \App\Models\UnidadeProduto::where('id', '=', $produto->idunidade_produto)->first();
                    if($valueItem["tipo_lancamento"] === "Produto")
                        $qtdProduto += intval($valueItem["quantidade"]);
                    if($valueItem["tipo_lancamento"] === "Serviço")
                        $qtdServico += intval($valueItem["quantidade"]);
                }
                $resumoItens = intval($qtdProduto + $qtdServico) . " Produto(s)";
                $listaFornecedores = array();
                foreach ($fornecedores as $valueItem) {
                    $listaItens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $valueItem->id)->get(['id', 'idfornecedorpedido','iditem','quantidadeFornecedor','valorUnitarioFornecedor','valorTotal']);
                    $listaItensAlterado = array();
                    foreach ($listaItens as $valueItemItem) {
                        $itemPedido = \App\Models\ItemPedido::where("id","=",$valueItemItem->iditem)->first(['id', 'idproduto','tipo_lancamento','quantidade']);
                        $listaItensAlterado[] = array("quantidade"=>$itemPedido["quantidade"],"idproduto"=>$itemPedido["idproduto"],"tipo_lancamento"=>$itemPedido["tipo_lancamento"],"item"=>$valueItemItem,"quantidadeFornecedor"=>$valueItemItem["quantidadeFornecedor"],"valorUnitarioFornecedor"=>$valueItemItem["valorUnitarioFornecedor"], );
                    }
                    $listaFornecedores[] = array("fornecedores"=>$valueItem, "item"=>$listaItensAlterado);
                }
                if(count($listaFornecedores)==0) {
                    $listaFornecedores = $fornecedores;
                }
                // $result[] = array("pedido"=>$value, "itens"=>$itens, "resumo" =>  $resumoItens, "fornecedores"=> $listaFornecedores);
                $value['pedido'] = $value->toArray();
                $value['usuario_solicitacao'] = Usuario::select('id','login as nome')->find($value->solicitado_id);
                $value['itens'] = $itens;
                $value['resumo'] = count($itens)." Produto(s)";
                $value['fornecedores'] = $listaFornecedores;
            }
            return response($Data);
        } else {
            $Data = DB::table('pedidos')->where('status','!=','Solicitado')->orderBy('created_at', 'desc')->get();
            $result = array();
            foreach ($Data as $value) {
                $itens = \App\Models\ItemPedido::where('idpedido', '=', $value->id)->get(['id', 'idpedido','idproduto','tipo_lancamento','quantidade']);
                $fornecedores = \App\Models\FornecedorPedido::where('idpedido', '=', $value->id)->get(['id', 'idpedido','idfornecedor','valorTotal','valorTotalCalculado','acrescimo','desconto','observacao','status']);
                $itensComDescricao = array();
                $qtd = 0;
                $resumoItens = "";
                $qtdProduto = 0;
                $qtdServico = 0;
                foreach ($itens as $valueItem) {
                    $produto = \App\Models\Produto::where('id', '=', $valueItem->idproduto)->first();
                    $unidade = \App\Models\UnidadeProduto::where('id', '=', $produto->idunidade_produto)->first();
                    if($valueItem["tipo_lancamento"] === "Produto")
                        $qtdProduto += intval($valueItem["quantidade"]); 
                    if($valueItem["tipo_lancamento"] === "Serviço")
                        $qtdServico += intval($valueItem["quantidade"]);                
                }
                //if($qtdProduto > 0){
                //    $resumoItens .= $qtdProduto . " Produto(s)";
                //}
                //if($qtdServico > 0){
                //    $resumoItens .= $qtdServico . " Serviços(s)";
                //}
                $resumoItens = intval($qtdProduto + $qtdServico) . " Produto(s)";
                //$resumoItens .= " " . $valueItem["quantidade"] ." " .$valueItem["tipo_lancamento"] . " (s)"; 
                $listaFornecedores = array();
                foreach ($fornecedores as $valueItem) {
                        $listaItens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $valueItem->id)->get(['id', 'idfornecedorpedido','iditem','quantidadeFornecedor','valorUnitarioFornecedor','valorTotal']);
                        $listaItensAlterado = array();
                        foreach ($listaItens as $valueItemItem) {
                            $itemPedido = \App\Models\ItemPedido::where("id","=",$valueItemItem->iditem)->first(['id', 'idproduto','tipo_lancamento','quantidade']);
                            $listaItensAlterado[] = array("quantidade"=>$itemPedido["quantidade"],"idproduto"=>$itemPedido["idproduto"],"tipo_lancamento"=>$itemPedido["tipo_lancamento"],"item"=>$valueItemItem,"quantidadeFornecedor"=>$valueItemItem["quantidadeFornecedor"],"valorUnitarioFornecedor"=>$valueItemItem["valorUnitarioFornecedor"], );
                        }
                        $listaFornecedores[] = array("fornecedores"=>$valueItem, "item"=>$listaItensAlterado);
                }
                if(count($listaFornecedores)==0) {
                    $listaFornecedores = $fornecedores;
                }
                $usuario_solicitante = Usuario::select('id','login as nome')->find($value->solicitado_id);
                $result[] = array("pedido"=>$value, "itens"=>$itens, "resumo" =>  $resumoItens, "fornecedores"=> $listaFornecedores, "usuario_solicitacao"=>$usuario_solicitante);
            }
            return response()->success($result);
        }
    }

    public function store(PedidoRequest $request)
    {
        try {
            $data = $request->all();

            $user = JWTAuth::parseToken()->authenticate();
            $data["solicitado_id"] = $user->id;
            $data["expectativa_entrega"] = DataHelper::setDateUTCtoDateDB($data["expectativa_entrega"]);
            $data["expectativa_valor"] = 0.00;
            $status = isset($data["solicitacao"]) ? 'Solicitado' : 'Em Cotacao';
            $data["status"] = $status;

            $Data = Pedido::create($data);
            foreach($request->input("listaItens") as $value){
                $obj = array(
                    "tipo_lancamento"=>'produto',
                    "idproduto"=>$value['idproduto'], 
                    "quantidade"=>$value['quantidade'],
                    "idpedido"=> $Data['id']);
                \App\Models\ItemPedido::create($obj);
            }
            if (isset($data["listaFornecedores"])) {
                $this->salvarFornecedores($Data["id"], $data["listaFornecedores"]);
            }
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    function salvarFornecedores($pedido,$listaFornecedores)
    {
        foreach ( $listaFornecedores as $fornecedor ) {
            $obj = array(
                    "idpedido"=>$pedido,
                    "idfornecedor"=>$fornecedor['id']);
                \App\Models\FornecedorPedido::create($obj);
        }
    }

    public function show($id)
    {
        $Data = Pedido::complete($id);
        if (count($Data)) {
            foreach($Data->itemsPedido as $item){
                $produto = Produto::find($item['idproduto']);
                $item['produto'] = $produto;
            }
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(Request $request, $id)
    {
        $Data = Pedido::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $data["expectativa_entrega"] = DataHelper::setDateUTCtoDateDB($data["expectativa_entrega"]);

                if($data["status"] == "Em cotação Email"){
                   $data["status"] = "Em cotação";
                   $this->salvarFornecedores($data["id"],$request->input("listaFornecedores"));
                }
                else if($data["status"] == "Em cotação"){
                    $this->salvarFornecedores($data["id"],$request->input("listaFornecedores"));
                }
                else if($data["status"] == "Em cotação Salvar"){
                    $data["status"] = "Em cotação";
                    $this->atualizarFornecedores($data["id"],$request->input("listaFornecedores"));
                    $this->excluirFornecedores($request->input("listaExcluirFornecedor"));
                }
                else if($data["status"] == "Aprovação da compra"){
                    $this->atualizarFornecedores($data["id"],$request->input("listaFornecedores"));
                    $this->excluirFornecedores($request->input("listaExcluirFornecedor"));
                }
                else if($data["status"] == "Em Aberto Aprovação"){
                    $data["status"] = "Em Aberto";
                    $this->excluirTodosFornecedores($request->input("listaFornecedores"));
                }
                else if($data["status"] == "Compra aprovada"){
                    $this->atualizarFornecedores($data["id"],$request->input("listaFornecedores"));
                }

                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    function atualizarFornecedores($pedido,$listaFornecedores)
    {
        foreach ( $listaFornecedores as $fornecedor ) {
            $obj = array(
                    "id"=>$fornecedor['idfornecedorpedido'],
                    "idpedido"=>$pedido,
                    "valorTotal"=>$fornecedor['valorTotal'],
                    "valorTotalCalculado"=>$fornecedor['valorTotalCalculado'],
                    "acrescimo"=>$fornecedor['acrescimo'],
                    "desconto"=>$fornecedor['desconto'],
                    "observacao"=>$fornecedor['observacao'],
                    "status"=>$fornecedor['status'],
                    "idfornecedor"=>$fornecedor['id']);

            if($fornecedor["idfornecedorpedido"] == 0){
                 $obj = \App\Models\FornecedorPedido::create($obj);
            }
            else{
                $Data = \App\Models\FornecedorPedido::find($fornecedor['idfornecedorpedido']);
                $Data->update($obj);
            }

            $this->atualizarListaItem($obj,$fornecedor["listaItens"],$pedido);
        }
    }

    function atualizarListaItem($fornecedor,$listaItemFornecedores,$pedido)
    {
        foreach ( $listaItemFornecedores as $itemFornecedor ) {
            if($itemFornecedor["idItem"] == 0) {
                $verificaProduto = ItemPedido::where('idpedido',$pedido)->where('idproduto',$itemFornecedor["idproduto"])->first();
                if(!count($verificaProduto)) {
                    $itemNovo = array(
                        "idpedido" => $pedido,
                        "idproduto" => $itemFornecedor["idproduto"],
                        "tipo_lancamento" => 'Produto',
                        "quantidade" => $itemFornecedor["quantidade"]
                    );
                    $idItemNovo = ItemPedido::create($itemNovo)->id;
                } else {
                    $idItemNovo = $verificaProduto->id;
                }
            }
            $idItem = $itemFornecedor["idItem"] == 0 ? $idItemNovo :$itemFornecedor["idItem"];
            $obj = array(
                    "id"=>$itemFornecedor['id'],
                    "idfornecedorpedido"=>$fornecedor["id"],
                    "iditem"=>$idItem,
                    "quantidadeFornecedor"=>$itemFornecedor['quantidadeFornecedor'],
                    "valorUnitarioFornecedor"=>$itemFornecedor['valorUnitarioFornecedor'],
                    "valorTotal"=>$itemFornecedor['valorTotal']);

            if($itemFornecedor['id'] == 0){
                \App\Models\ItemFornecedorPedido::create($obj);
            }else{
                $Data = \App\Models\ItemFornecedorPedido::find($itemFornecedor['id']);
                $Data->update($obj);
            }
        }
    }

    function excluirFornecedores($listaFornecedores)
    {
        foreach ( $listaFornecedores as $fornecedor ) {
            $listaitens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $fornecedor)->get(['id']);
            foreach ( $listaitens as $item ) {
                $Data = \App\Models\ItemFornecedorPedido::find($item["id"]);
                $Data->delete();
            }
            $Data = \App\Models\FornecedorPedido::find($fornecedor);
            if($Data !== null){
                $Data->delete();
            }
        }
    }

    function excluirTodosFornecedores($listaFornecedores)
    {
        foreach ( $listaFornecedores as $fornecedor ) {
            $listaitens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $fornecedor["idfornecedorpedido"])->get(['id']);
            foreach ( $listaitens as $item ) {
                $Data = \App\Models\ItemFornecedorPedido::find($item["id"]);
                $Data->delete();
            }
            $Data = \App\Models\FornecedorPedido::find($fornecedor["idfornecedorpedido"]);
            $Data->delete();
        }
    }

    public function destroy($id)
    {
        $Data = Pedido::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function getInfoMov($idPedido)
    {
        try {
            $pedido = \App\Models\Pedido::find($idPedido);
            $lanAgd = \App\Models\LancamentoAgendar::find($pedido->id_lancamento_agendar);
            $obj = [];
            $obj['operacao'] = 'compras';
            $obj['observacao'] = 'entrada pedido ';
            $obj['tipo'] = 'entrada';
            $obj['numero_nota'] = $lanAgd['numero_nf'];
            $obj['valor_nota'] = $lanAgd['valor'];
            $obj['id_fornecedor'] = $lanAgd['id_fornecedor'];
            $obj['valor_itens'] = $pedido['expectativa_valor'];      
            $obj['estoque'] = [];          
            $obj['patrimonio'] = [];
            $itemsPedido = \App\Models\ItemPedido::where('idpedido', $pedido->id)->get();
            foreach( $itemsPedido as $item) {
                $produto = \App\Models\Produto::where('id',$item->idproduto)->select('id','descricao','quantidade_atual','tipo')->first();
                if($produto['tipo'] == 0){
                    array_push($obj['estoque'], [
                        'quantidade' => $item->quantidade,
                        'produto' => $produto
                    ]);
                } elseif($produto['tipo'] == 1){
                    array_push($obj['patrimonio'], [
                        'quantidade' => $item->quantidade,
                        'produto' => $produto
                    ]);
                }
            }
            return response($obj);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function movProdutos($idPedido)
    {
        try {
            \DB::beginTransaction();
            $pedido = \App\Models\Pedido::find($idPedido);
            $lanAgd = \App\Models\LancamentoAgendar::find($pedido->id_lancamento_agendar);
            $FornecedorPedido = \App\Models\FornecedorPedido::where('idpedido', $pedido->id)->where('status', 'Aprovado')->first();
            $obj = [];
            $obj['operacao'] = 'compras';
            $obj['observacao'] = 'Entrada automática pelo sistema de compras';
            $obj['tipo'] = 'entrada';
            $obj['numero_nota'] = $lanAgd['numero_nf'];
            $obj['valor_nota'] = $lanAgd['valor'];
            $obj['id_fornecedor'] = $lanAgd['id_fornecedor'];
            $obj['valor_itens'] = $FornecedorPedido->valorTotalCalculado;
            $obj['data_compra'] = $lanAgd['created_at'];          
            $obj['estoque'] = [];
            $obj['patrimonio'] = [];
            $obj['id_pedido'] = $idPedido;
            $itemsPedido = \App\Models\ItemPedido::where('idpedido', $pedido->id)->get();
            foreach($itemsPedido as $item) {
                $itemFornecedorPedido = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', $FornecedorPedido->id)
                 ->where('iditem', $item->id)->first();
                $produto = \App\Models\Produto::where('id',$item->idproduto)->select('id','descricao','quantidade_atual','tipo')->first();
                if($produto['tipo'] == 0){
                    array_push($obj['estoque'], [
                        'quantidade' => $item->quantidade,
                        'id_produto' => $item->idproduto
                    ]);
                } elseif($produto['tipo'] == 1){
                    array_push($obj['patrimonio'], [
                        'quantidade' => $item->quantidade,
                        'id_produto' => $item->idproduto,
                        'valorUnitarioFornecedor' => $itemFornecedorPedido->valorUnitarioFornecedor,
                        'id_departamento' => $lanAgd->id_departamento
                    ]);
                }
            }
            if(count($obj['estoque'])){
                $estMov = new \App\Models\EstoqueMovimentacao();
                $estMov->createMov($obj);
            } if(count($obj['patrimonio'])){
                $estMov = new \App\Models\PatrimonioBem();
                $estMov->createBemPedido($obj);
            }
            \DB::commit();
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
    }

    public function solicitacao(Request $request)
    {
        $data = $request->all();
        $Data = Pedido::with(['itemsPedido' => function($q) {
                $q->with(['produto' => function($q) {
                    $q->select('id','idgrupo_produto','descricao');
                    $q->with(['grupo_produto' => function($q) {
                        $q->select('id','descricao');
                    }]);
                }]);
            }])
            ->select('pedidos.*')
            ->selectRaw('DATE_FORMAT(expectativa_entrega, "%d/%m/%Y") as expectativa_entrega');
        if (isset($data["tag"]) && $data["tag"] != '') {
            $Data = $Data->where('descricao','like','%'.$data["tag"].'%')->orWhere('requerente','like','%'.$data["tag"].'%');
        }
        $Data = $Data->where('solicitacao',1)->orderBy('id','DESC')->paginate(11);
        return response($Data);
    }

    public function deleteItensByPedido(Request $request)
    {
        $data = $request->all();
        $Data = \DB::table('item_pedidos')->where('idpedido',$data["idpedido"])->delete();
        return response($Data);
    }

    public function aprovacao(Request $request)
    {
        $data = $request->all();
        if(isset($data['page'])){
            $Data = \App\Models\Pedido::orderBy('created_at', 'desc')->paginate(13);
            foreach ($Data->Items() as $value) {
                $itens = \App\Models\ItemPedido::with('produto:id,descricao')->where('idpedido', '=', $value->id)->get(['id', 'idpedido','idproduto','tipo_lancamento','quantidade']);
                $fornecedores = \App\Models\FornecedorPedido::with('empresa:id,nome_fantasia')->where('idpedido', '=', $value->id)->get(['id', 'idpedido','idfornecedor','valorTotal','valorTotalCalculado','acrescimo','desconto','observacao','status']);
                $itensComDescricao = array();
                $qtd = 0;
                $resumoItens = "";
                $qtdProduto = 0;
                $qtdServico = 0;
                foreach ($itens as $valueItem) {
                    $produto = \App\Models\Produto::where('id', '=', $valueItem->idproduto)->first();
                    $unidade = \App\Models\UnidadeProduto::where('id', '=', $produto->idunidade_produto)->first();
                    if($valueItem["tipo_lancamento"] === "Produto")
                        $qtdProduto += intval($valueItem["quantidade"]);
                    if($valueItem["tipo_lancamento"] === "Serviço")
                        $qtdServico += intval($valueItem["quantidade"]);
                }
                $resumoItens = intval($qtdProduto + $qtdServico) . " Produto(s)";
                $listaFornecedores = array();
                foreach ($fornecedores as $valueItem) {
                    $listaItens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $valueItem->id)->get(['id', 'idfornecedorpedido','iditem','quantidadeFornecedor','valorUnitarioFornecedor','valorTotal']);
                    $listaItensAlterado = array();
                    foreach ($listaItens as $valueItemItem) {
                        $itemPedido = \App\Models\ItemPedido::where("id","=",$valueItemItem->iditem)->first(['id', 'idproduto','tipo_lancamento','quantidade']);
                        $listaItensAlterado[] = array("quantidade"=>$itemPedido["quantidade"],"idproduto"=>$itemPedido["idproduto"],"tipo_lancamento"=>$itemPedido["tipo_lancamento"],"item"=>$valueItemItem,"quantidadeFornecedor"=>$valueItemItem["quantidadeFornecedor"],"valorUnitarioFornecedor"=>$valueItemItem["valorUnitarioFornecedor"], );
                    }
                    $listaFornecedores[] = array("fornecedores"=>$valueItem, "item"=>$listaItensAlterado);
                }
                if(count($listaFornecedores)==0) {
                    $listaFornecedores = $fornecedores;
                }
                // $result[] = array("pedido"=>$value, "itens"=>$itens, "resumo" =>  $resumoItens, "fornecedores"=> $listaFornecedores);
                $value['pedido'] = $value->toArray();
                $value['usuario_solicitacao'] = Usuario::select('id','login as nome')->find($value->solicitado_id);
                $value['itens'] = $itens;
                $value['resumo'] = count($itens)." Produto(s)";
                $value['fornecedores'] = $listaFornecedores;
            }
            return response($Data);
        } else {
            $Data = DB::table('pedidos')->whereIn('status', ['Solicitado','Aprovação da compra'])->orderBy('created_at', 'desc')->get();
            $result = array();
            foreach ($Data as $value) {
                $itens = \App\Models\ItemPedido::with('produto:id,descricao')->where('idpedido', '=', $value->id)->get(['id', 'idpedido','idproduto','tipo_lancamento','quantidade']);
                $fornecedores = \App\Models\FornecedorPedido::where('idpedido', '=', $value->id)->get(['id', 'idpedido','idfornecedor','valorTotal','valorTotalCalculado','acrescimo','desconto','observacao','status']);
                $itensComDescricao = array();
                $qtd = 0;
                $resumoItens = "";
                $qtdProduto = 0;
                $qtdServico = 0;
                foreach ($itens as $valueItem) {
                    $produto = \App\Models\Produto::where('id', '=', $valueItem->idproduto)->first();
                    $unidade = \App\Models\UnidadeProduto::with('empresa:id,nome_fantasia')->where('id', '=', $produto->idunidade_produto)->first();
                    if($valueItem["tipo_lancamento"] === "Produto")
                        $qtdProduto += intval($valueItem["quantidade"]);
                    if($valueItem["tipo_lancamento"] === "Serviço")
                        $qtdServico += intval($valueItem["quantidade"]);
                }
                $resumoItens = intval($qtdProduto + $qtdServico) . " Produto(s)";
                //$resumoItens .= " " . $valueItem["quantidade"] ." " .$valueItem["tipo_lancamento"] . " (s)";
                $listaFornecedores = array();
                foreach ($fornecedores as $valueItem) {
                    $listaItens = \App\Models\ItemFornecedorPedido::where('idfornecedorpedido', '=', $valueItem->id)->get(['id', 'idfornecedorpedido','iditem','quantidadeFornecedor','valorUnitarioFornecedor','valorTotal']);
                    $listaItensAlterado = array();
                    foreach ($listaItens as $valueItemItem) {
                        $itemPedido = \App\Models\ItemPedido::where("id","=",$valueItemItem->iditem)->first(['id', 'idproduto','tipo_lancamento','quantidade']);
                        $listaItensAlterado[] = array("quantidade"=>$itemPedido["quantidade"],"idproduto"=>$itemPedido["idproduto"],"tipo_lancamento"=>$itemPedido["tipo_lancamento"],"item"=>$valueItemItem,"quantidadeFornecedor"=>$valueItemItem["quantidadeFornecedor"],"valorUnitarioFornecedor"=>$valueItemItem["valorUnitarioFornecedor"], );
                    }
                    $listaFornecedores[] = array("fornecedores"=>$valueItem, "item"=>$listaItensAlterado);
                }
                if(count($listaFornecedores)==0) {
                    $listaFornecedores = $fornecedores;
                }
                $usuario_solicitante = Usuario::select('id','login as nome')->find($value->solicitado_id);
                $result[] = array("pedido"=>$value, "itens"=>$itens, "resumo" =>  $resumoItens, "fornecedores"=> $listaFornecedores, "usuario_solicitacao"=>$usuario_solicitante);
            }
            return response()->success($result);
        }
    }

    public function imprimirSolicitacao(Request $request)
    {
        $data = $request->all();
        $condominio = Condominio:: first();
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }

        $html = '<html><header>';
        $html .= $this->html_reset_css;
        $html .= '<style>th{ background-color: #f1f1f1;padding: 3px 3px;border-right: 1px solid #929292;} td{ padding: 3px;}</style>';
        $html .= '</header><body>';
        $html .= '<table style="width: 100%;border-bottom: 1px solid #ccc">
                        <tr>
                            <td style="vertical-align: top">
                                <img style="padding: 1px;width: 80px;" src="'.$path_logo.'"><br>
                                <h3>'.$condominio->nome_fantasia.'</h3>
                            </td>
                            <td style="vertical-align: middle;">
                                <h2 style="font-size: 20px;text-align:left;padding-bottom: 10px; ">Solicitação de Compra</h2>
                            </td>
                        </tr>
                        <tr><td>&nbsp;</td></tr>
                   </table>';
        $html .= '<table class="solicitacao">
                    <tr>
                        <td style="width: 30%"><b>Requerente: &nbsp;</b>'.$data["requerente"].'</td>
                        <td style="width: 45%"><b>Usuário: &nbsp;</b>'.camel_case($data["solicitado"]).'</td>
                        <td><b>Solicitado em: &nbsp;</b>'.DataHelper::getPrettyDate($data["dt_criacao"]).'</td>
                    </tr>
                    <tr>
                        <td colspan="3"><b>Descrição: &nbsp;</b> '.$data["descricao"].'</td>
                    </tr>
                </table>';
        $html .= '<h2 style="font-size: 14px;margin-top: 20px">Itens</h2>
                  <table border="1" class="solicitacao">
                    <tr>
                        <th>TIPO</th>
                        <th>PRODUTO</th>
                        <th>QUANTIDADE</th>
                    </tr>';
        foreach ($data["listaItens"] as $itens) {
            $html .= '<tr>
                        <td> '.$itens["produto"]["grupo_produto"]["descricao"].'</td>
                        <td> '.$itens["produto"]["descricao"].'</td>
                        <td style="text-align: center"> '.$itens["quantidade"].'</td>
                      </tr>';
        }
        $html .= '</table>
                  <table class="solicitacao" style="margin-top: 60px">
                    <tr><td style="text-align: center" colspan="2"><b>ASSINATURA / PERMISSÃO</b></td></tr>
                    <tr>
                        <td style="text-align: center;padding-top: 60px;border: none;">____________________________________________________________________________________<br>Aprovação</td>
                        <td style="text-align: center;padding-top: 60px;border: none;">________________________________________<br>Cidade / Data</td>
                    </tr>
                  </table>';

        $html .= '</body></html>';
        $footer = $this->pdf_footer('Solicitação de Compra', $condominio->nome_fantasia);

        $mpdf = new PrintPdf('', 'A4', 7, 'FreeSans', 5, 5, 10, 15, 8, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function pdf_footer($titulo, $condominio){
        $pdf_footer = '<table width="100%" style="vertical-align: bottom; font-family: serif; font-size: 8px; color: #000000; font-style: italic;">
                    <tr>
                        <td width="33%"><span style="font-style: italic;">{DATE d/m/Y - H:i:s}</span></td>
                        <td width="33%" align="center" style="font-style: italic;">{PAGENO} de {nbpg}</td>
                        <td width="33%" style="text-align:center;">' .$titulo.' - '.$condominio.'</td>
                    </tr>
                    </table>';
        return $pdf_footer;
    }

    public function imprimirCotacao(Request $request)
    {
        $data = $request->all();
        $condominio = Condominio:: first();
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if ($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }

        $html = '<html><header>';
        $html .= $this->html_reset_css;
        $html .= '<style>th{ background-color: #f1f1f1;padding: 3px 3px;border-right: 1px solid #929292;} td{ padding: 3px;}</style>';
        $html .= '</header><body>';
        $html .= '<table class="solicitacao">
                        <tr>
                            <td colspan="2" style="vertical-align: top;width: 5px;">
                                <img style="padding: 1px;width: auto;" src="' . $path_logo . '"><br>
                            </td>
                            <td colspan="2" style="vertical-align: middle;width: 20px;">
                                <h3 class="mapa-coleta-titulo">' . $condominio->nome_fantasia . '<br>Mapa de coleta de preços</h3>
                            </td>';
        foreach ($data["listaFornecedores"] as $fornecedores) {
            $html .=        '<td colspan="4" style="vertical-align: middle;width: 25px;">
                                <b>Empresa</b><br>'.$fornecedores["nome_fantasia"].'
                            </td>';
        }
        $html .= '      </tr>
                        <tr style="border: none"><td colspan="10" style="border: none"></td></tr>
                        <tr class="head-item">
                            <td style="vertical-align: middle;width: 10px">ITEM</td>
                            <td style="vertical-align: middle;width: 10px">QTD</td>
                            <td style="vertical-align: middle;width: 10px">UNID</td>
                            <td style="vertical-align: middle;width: 90px">PRODUTO</td>';
        foreach ($data["listaFornecedores"] as $fornecedores) {
            $html .=       '<td style="vertical-align: middle;width: 10px" colspan="2">P.UNIT</td>
                            <td style="vertical-align: middle;width: 10px" colspan="2">TOTAL</td>';
        }
        $html .= '      </tr>';
        foreach ($data["listaItens"] as $key => $itens) {
            \Log::debug($itens);
            $html .=    '<tr class="item-lista">
                            <td style="vertical-align: middle;width: 10px" class="center">'.($key+1).'</td>
                            <td style="vertical-align: middle;width: 10px" class="center">'.$itens["quantidade"].'</td>
                            <td style="vertical-align: middle;width: 10px" class="center">UN</td>
                            <td>'.$itens["nome"].'</td>';
            foreach ($data["listaFornecedores"] as $fornecedores) {
                foreach ($fornecedores["listaItens"] as $listaItens) {
                    if ($listaItens["idItem"] == $itens["id"]) {
                        $html .= '<td class="moeda">R$</td>
                                  <td class="right valor">'.DataHelper::getDoubleToReal($listaItens["valorUnitarioFornecedor"]).'</td>
                                  <td class="moeda">R$</td>
                                  <td class="right valor">'.DataHelper::getDoubleToReal($listaItens["valorTotal"]).'</td>';
                    }
                }
            }
            $html .=    '</tr>';
        }
        $totais = [
            ['tipo' => 'Acréscimo', 'cod' => 'acrescimo'],
            ['tipo' => 'Desconto', 'cod' => 'desconto'],
            ['tipo' => 'Total', 'cod' => 'valorTotalCalculado']
        ];
        foreach ($totais as $total) {
            $html .= '<tr class="item-lista">
                          <td colspan="4"></td>';
            foreach ($data["listaFornecedores"] as $fornecedores) {
                $bold = $total["cod"] === 'valorTotalCalculado' ? 'style=font-weight:bold' : '';
                $html .= '<td class="right" colspan="2" '.$bold.'>'.$total["tipo"].'</td>
                          <td class="moeda" '.$bold.'>R$</td>';
                if ($total["cod"] === 'acrescimo')
                    $html .='<td class="right valor">'.DataHelper::getDoubleToReal($fornecedores["acrescimo"]).'</td>';
                elseif ($total["cod"] === 'desconto')
                    $html .='<td class="right valor">'.DataHelper::getDoubleToReal($fornecedores["desconto"]).'</td>';
                else
                    $html .='<td class="right valor"><b>'.DataHelper::getDoubleToReal($fornecedores["valorTotalCalculado"]).'</b></td>';
            }
            $html .= '</tr>';
        }
        $html .='</table>
                <table class="solicitacao">
                    <tr>
                        <td><b>Descrição: </b>'.$data["descricao"].'<br></td>
                    </tr>      
                </table>';
        $html .='</table>
                <table class="solicitacao">
                    <tr><td colspan="2">Assinaturas / Aprovações</td></tr>
                    <tr>
                        <td class="center" style="vertical-align: bottom" height="100">
                        ________________________________________________________________<br>Cotação
                        </td>
                        <td class="center" style="vertical-align: bottom" >
                        ________________________________________________________________<br>Aprovação
                        </td>
                        
                    </tr>      
                </table>';

        $footer = $this->pdf_footer('Cotação de compras', $condominio->nome_fantasia);

        $mpdf = new PrintPdf('', 'A4-L', 10, 'FreeSans', 5, 5, 10, 15, 8, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function notificacaoAprovador(Request $request)
    {
        $data = $request->all();

        $content = [
            "mensagem" => '<h2>Novo pedido de Compra</h2>
                            <span style="font-size: 14px">Uma nova solicitação está aguardando sua aprovação no sistema bioacesso financeiro. </span><br>
                            <p>
                                <b>Requerente: </b>'.$data["requerente"].'<br>
                                <b>Descrição: </b>'.$data["descricao"].'
                                <b>Data/hora: </b>'.date('d/m/Y H:i:s').'
                            </p>
                            <br>
                            <i>Acesse o sistema para mais detalhes.</i>
                          '
        ];
        $aprovadores = Aprovador::where('tipo','like','%Painel%')->get();
        if (count($aprovadores)) {
            foreach ($aprovadores as $aprovador) {
                \Mail::to($aprovador["email"])->send(new SendMail($content, 'emails.email', 'Pedido compras - Bioacesso Financeiro'));
            }
            return 'enviado';
        } else {
            return 'Aprovadores não encontrado.';
        }
    }

}