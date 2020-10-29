<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Models\ItemPedido;
use App\Models\Pedido;
use App\Models\Solicitacao;
use function foo\func;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;

class SolicitacaoController extends Controller
{
    private $name = 'Solicitação';
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = Solicitacao::with(['pedidos' => function($q) {
                $q->with(['itemsPedido' => function($q) {
                    $q->with(['produto' => function($q) {
                        $q->select('id','idgrupo_produto','descricao');
                        $q->with(['grupo_produto' => function($q) {
                            $q->select('id','descricao');
                        }]);
                    }]);
                }]);
                $q->select('id','solicitado_id','id_solicitacao','descricao','status');
                $q->selectRaw('DATE_FORMAT(expectativa_entrega, "%d/%m/%Y") as expectativa_entrega');
            }])
            ->orderBy('id','DESC')->paginate(11);
        return response($Data);
    }

    public function pesquisa(Request $request)
    {
        $data = $request->all();
        $Data = Solicitacao::whereHas('pedidos', function($q) use($data) {
                $q->where('descricao','like','%'.$data["tag"].'%');
            })
            ->with(['pedidos' => function($q) {
            $q->with(['itemsPedido' => function($q) {
                $q->with(['produto' => function($q) {
                    $q->select('id','idgrupo_produto','descricao');
                    $q->with(['grupo_produto' => function($q) {
                        $q->select('id','descricao');
                    }]);
                }]);
            }]);
            $q->select('id','solicitado_id','id_solicitacao','descricao','status');
            $q->selectRaw('DATE_FORMAT(expectativa_entrega, "%d/%m/%Y") as expectativa_entrega');
        }])
            ->orderBy('id','DESC')->paginate(11);
        return response()->success($Data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();
        $user = JWTAuth::parseToken()->authenticate();
        $data["expectativa_entrega"] = DataHelper::setDateUTCtoDateDB($data["expectativa_entrega"]);
        $data["expectativa_valor"] = 0.00;
        $data["solicitado_id"] = $user->id;
        $data["status"] = 'Solicitado';
        try {
            \DB::beginTransaction();
            //cria pedido
            $pedido = Pedido::create($data);
            $data["id_pedido"] = $pedido->id;
            //cria solicitação
            $solicitacao = Solicitacao::create($data);
            //atualiza id_solicitação em pedidos
            $updatePedido = Pedido::find($pedido->id);
            $updatePedido->id_solicitacao = $solicitacao->id;
            $updatePedido->save();
            //item do pedido
            foreach($data["listaItens"] as $value){
                $obj = array(
                    "tipo_lancamento"=>'Produto',
                    "idproduto"=>$value['idproduto'],
                    "quantidade"=>$value['quantidade'],
                    "idpedido"=> $pedido->id);
                ItemPedido::create($obj);
            }
            \DB::commit();
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id){
        $solicitacao = Solicitacao::find($id);
        $pedido = Pedido::find($solicitacao->id_pedido);
        if (count($solicitacao)) {
            try {
                \DB::beginTransaction();
                $solicitacao->delete();
                $pedido->delete();
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }
}
