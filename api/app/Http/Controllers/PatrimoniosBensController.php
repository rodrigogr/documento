<?php
namespace App\Http\Controllers;

use App\Http\Requests\PatrimonioBensRequest;
use App\Models\PatrimonioBem;
use Illuminate\Database\QueryException;

class PatrimoniosBensController extends PatrimoniosController
{
    private $name = 'Bem patrimonial';

    public function index()
    {
        $result = [];
        $data = PatrimonioBem::with(['departamento', 'produto', 'produto.grupo_produto'])
            ->get();
        if (count($data)) {
            foreach ($data as $item) {
                $result[] = $item;
            }
        }
         return response()->success($data);
    }

    public function bensSemPendencia()
    {
        $result = [];
        $data = PatrimonioBem::with(['departamento', 'produto', 'produto.grupo_produto'])
            ->whereHas('historico', function ($q) {
                $q->whereRaw('id IN (SELECT max(id) FROM patrimonios_historicos GROUP BY id_patrimonio)');
                $q->where('status','!=','PENDENTE');
                $q->select('id_patrimonio','status');
                $q->orderBy('data_hora','desc');
            })
            ->get();
        if (count($data)) {
            foreach ($data as $item) {
                $result[] = $item;
            }
        }
        return response()->success($data);
    }

    public function store(PatrimonioBensRequest $request)
    {
        try {
            \DB::beginTransaction();
            $model = new PatrimonioBem;
            $model->id_produto = $request->id_produto;
            $model->numero = $request->numero;
            $model->serie = $request->serie ? $request->serie : null;
            $model->descricao_garantia = $request->descricao_garantia ? $request->descricao_garantia : null;
            $model->fim_garantia = $request->fim_garantia ? $request->fim_garantia : null;
            $model->tipo_lancamento = $request->tipo_lancamento;
            $model->tipo_incorporacao = $request->tipo_incorporacao;
            $model->data_incorporacao = $request->data_incorporacao;
            $model->data_compra = $request->data_compra ? $request->data_compra : null;
            $model->valor = $request->valor;
            $model->id_empresa = $request->id_empresa ? $request->id_empresa : null;
            $model->numero_nota_fiscal = $request->numero_nota_fiscal ? $request->numero_nota_fiscal : null;
            $model->id_departamento = $request->id_departamento;
            $model->observacoes = $request->observacoes ? $request->observacoes : null;
            $model->save();
            $this->gravaHistorico('Ativo', $model->id);
            \DB::commit();
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        } catch (QueryException $q) {
            \DB::rollBack();
            return response()->error('Problemas ao gravar registro! <> ' . $q->getMessage());
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }

    public function update(PatrimonioBensRequest $request, $id)
    {
        try {
            \DB::beginTransaction();
            $model = PatrimonioBem::find($id);
            $model->id_produto = $request->id_produto;
            $model->numero = $request->numero;
            $model->serie = $request->serie ? $request->serie : null;
            $model->descricao_garantia = $request->descricao_garantia ? $request->descricao_garantia : null;
            $model->fim_garantia = $request->fim_garantia ? $request->fim_garantia : null;
            $model->tipo_lancamento = $request->tipo_lancamento;
            $model->tipo_incorporacao = $request->tipo_incorporacao;
            $model->data_incorporacao = $request->data_incorporacao;
            $model->data_compra = $request->data_compra ? $request->data_compra : null;
            $model->valor = $request->valor;
            $model->id_empresa = $request->id_empresa ? $request->id_empresa : null;
            $model->numero_nota_fiscal = $request->numero_nota_fiscal ? $request->numero_nota_fiscal : null;
            $model->id_departamento = $request->id_departamento;
            $model->observacoes = $request->observacoes ? $request->observacoes : null;
            $model->update();
            $this->gravaHistorico('Ativo', $model->id);
            \DB::commit();
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        } catch (QueryException $q) {
            \DB::rollBack();
            return response()->error('Problemas ao gravar registro! <> ' . $q->getMessage());
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }
}
