<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Http\Requests\PreLancamentoRequest;
use App\Models\ImovelPermanente;
use App\Models\PreLancamento;
use App\Models\Lancamento;
use App\Models\Recebimento;
use App\Models\ReceitaCalculo;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use App\Helpers\DataHelper;

class PreLancamentoController extends Controller
{
    private $name = 'Pré-Lançamento';

    public function index(Request $request){
        $req = $request->input();
        $Data = PreLancamento::with('imovel');
        $Data = $Data->with('lancamento');
        if (isset($req['mes']) && $req['mes']>0) {
            $Data = $Data->where('mes',$req['mes']);
        }
        if (isset($req['ano']) && $req['ano']>0) {
            $Data = $Data->where('ano',$req['ano']);
        }
        $Data = $Data->orderBy('id_lancamento','desc')->paginate(13);
        foreach ($Data->Items() as $item){
            $morador = ImovelPermanente::where('id_imovel','=',$item->idimovel)->where('pessoa_titular','=',1)->where('excluido','=','n')->get();
            $item['nome_morador'] = $morador->first()->pessoa->nome;
        }
        return response($Data);
    }

    public function store(PreLancamentoRequest $request){
        try {
            \DB::beginTransaction();
            $data = $request->all();
            $data = array_add($data,'saldo_receber',$data['valor']);
            if($data['desconto']){
                $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Descontos'));
            } else {
                $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Outros'));
            }
            $lancamento = Lancamento::create($data);
            $data['id_lancamento'] = $lancamento->id;
            $data['mes'] = (int)$data['mes'];
            $data['ano'] = (int)$data['ano'];
            $Data = PreLancamento::create($data);
            \DB::commit();
            return response()->success($this->name.' cadastrado.');
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
//        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        return $data;
    }

    public function show($id){
        $Data = PreLancamento::complete($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(PreLancamentoRequest $request, $id){
        $lancamento = Lancamento::find($id);
        $Data = PreLancamento::find($id);
        if (count($Data)and count($lancamento)) {
            try {
                \DB::beginTransaction();
                $data = $request->all();
                if($data['desconto']){
                    $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Descontos'));
                } else {
                    $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Outros'));
                }
                $data = array_add($data,'saldo_receber',$data['valor']);
                $lancamento->update($data);
                $Data->update($data);
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                    return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
             return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = PreLancamento::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
                $lancamento = Lancamento::find($id);
                $lancamento->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            } catch (QueryException $q){
                if($q->getCode()=="23000"){
                    return response()->error("Este registro não pode ser excluido. Há registro(s) de  informações associado(s) a ele.");
                }
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function checkCalculados(Request $request)
    {
        $dados = $request->all();
        $result = ReceitaCalculo::whereYear('data_vencimento',$dados["ano"])
            ->whereMonth('data_vencimento',$dados["mes"])
            ->first();
        return count($result) ? response()->success(true) : response()->success(false);

    }
}
