<?php
namespace App\Http\Controllers;

use App\Http\Requests\PatrimonioManutencaoRequest;
use Illuminate\Database\QueryException;
use App\Models\PatrimonioManutencao;
use App\Models\PatrimonioBaixa;

class PatrimoniosManutencoesController extends PatrimoniosController
{
    private $name = 'Manutenção de patrimônio';

    public function index()
    {
         $result = [];
        $data = PatrimonioManutencao::with(['patrimonio', 'patrimonio.produto', 'patrimonio.produto.grupo_produto', 'fornecedor'])->get();

        if (count($data)) {
            foreach ($data as $item) {
                $result[] = $item;
            }
        }

        return response()->success($result);
    }

    public function store(PatrimonioManutencaoRequest $request)
    {
        try {
            \DB::beginTransaction();

            // Confere se o produto possui alguma baixa não revogada.
            $baixas = PatrimonioBaixa::query()
                    -> whereNull('motivo_revogacao')
                    -> where('id_patrimonio', '=', $request->id_patrimonio)
                    -> get();

            if (count($baixas) > 0) {
                throw new \Exception('Não foi possível gerar o registro porque este patrimônio possui baixa cadastrada.');
            }

            $model = new PatrimonioManutencao;

            $model->id_patrimonio = $request->id_patrimonio;
            $model->id_usuario = $request->id_usuario;
            $model->motivo = $request->motivo;
            $model->id_empresa = $request->id_empresa ? $request->id_empresa : null;
            $model->data_saida = $request->data_saida;
            $model->previsao_retorno = $request->previsao_retorno ? $request->previsao_retorno : null;
            $model->data_retorno = $request->data_retorno ? $request->data_retorno : null;
            $model->valor_orcamento = $request->valor_orcamento ? $request->valor_orcamento : null;
            $model->valor_pago = $request->valor_pago ? $request->valor_pago : null;
            $model->fim_garantia = $request->fim_garantia ? $request->fim_garantia : null;

            $model->save();
            $this->gravaHistorico('Em manutencao', $model->id_patrimonio);

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

    public function update(PatrimonioManutencaoRequest $request, $id)
    {
        try {
            \DB::beginTransaction();

            $model = PatrimonioManutencao::find($id);

            $model->id_patrimonio = $request->id_patrimonio;
            $model->id_usuario = $request->id_usuario;
            $model->motivo = $request->motivo;
            $model->id_empresa = $request->id_empresa ? $request->id_empresa : null;
            $model->data_saida = $request->data_saida;
            $model->previsao_retorno = $request->previsao_retorno ? $request->previsao_retorno : null;
            $model->data_retorno = $request->data_retorno ? $request->data_retorno : null;
            $model->valor_orcamento = $request->valor_orcamento ? $request->valor_orcamento : null;
            $model->valor_pago = $request->valor_pago ? $request->valor_pago : null;
            $model->fim_garantia = $request->fim_garantia ? $request->fim_garantia : null;

            $model->update();

            if ($request->data_retorno) {
                $this->gravaHistorico('Reparado/ativo', $model->id_patrimonio);
            }

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
