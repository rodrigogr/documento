<?php
namespace App\Http\Controllers;

use App\Http\Requests\PatrimonioBaixaRequest;
use App\Models\Empresa;
use App\Models\ImovelPermanente;
use App\Models\PatrimonioBaixa;

class PatrimoniosBaixasController extends PatrimoniosController
{
    private $name = 'Baixa de patrimônio';

    public function index()
    {
        $result = [];
        $data = PatrimonioBaixa::with(['patrimonio', 'patrimonio.produto', 'patrimonio.produto.grupo_produto'])->whereNull('motivo_revogacao')->get();

        if (count($data)) {
            foreach ($data as $item) {
                 $result[] = $item;
            }
        }

        return response()->success($result);
    }

    public function store(PatrimonioBaixaRequest $request)
    {
        try {
            \DB::beginTransaction();

            // Confere se o produto possui alguma baixa não revogada.
            $baixas = PatrimonioBaixa::query()
                    -> whereNull('motivo_revogacao')
                    -> where('id_patrimonio', '=', $request->id_patrimonio)
                    -> get();

            if (count($baixas) > 0) {
                throw new \Exception('Não é possível gerar mais de uma baixa para o mesmo patrimonio');
            }

            $model = new PatrimonioBaixa;

            $model->id_patrimonio = $request->id_patrimonio;

            if ($request->data > date('Y-m-d')) {
                throw new \Exception('A data da baixa não pode ser posterior ao dia de hoje');
            }
            $model->data = $request->data;

            $model->tipo = $request->tipo;
            $model->situacao = $request->situacao;
            $model->nota_fiscal_saida = $request->nota_fiscal_saida ? $request->nota_fiscal_saida : null;
            $model->destinatario = $request->destinatario ? $request->destinatario : null;
            $model->motivo = $request->motivo ? $request->motivo : null;
            $model->valor = $request->valor;
            $model->motivo_revogacao = $request->motivo_revogacao ? $request->motivo_revogacao : null;

            $model->save();
            $this->gravaHistorico('Baixado', $model->id_patrimonio);

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

    public function update(PatrimonioBaixaRequest $request, $id)
    {
        try {
            \DB::beginTransaction();

            $model = PatrimonioBaixa::find($id);

            $model->id_patrimonio = $request->id_patrimonio;
            $model->data = $request->data;
            $model->tipo = $request->tipo;
            $model->situacao = $request->situacao;
            $model->nota_fiscal_saida = $request->nota_fiscal_saida ? $request->nota_fiscal_saida : null;
            $model->destinatario = $request->destinatario ? $request->destinatario : null;
            $model->motivo = $request->motivo ? $request->motivo : null;
            $model->valor = $request->valor;
            $model->motivo_revogacao = $request->motivo_revogacao ? $request->motivo_revogacao : null;

            $model->update();

            if ($request->motivo_revogacao) {
                $this->gravaHistorico('Baixa revogada/ativo', $model->id_patrimonio);
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
