<?php
namespace App\Http\Controllers;

use App\Http\Requests\PatrimonioApoliceRequest;
use Illuminate\Database\QueryException;
use App\Models\PatrimonioApolice;

class PatrimoniosApolicesController extends PatrimoniosController
{
    private $name = 'Apólice de seguro';

    public function index()
    {
        $result = [];
        $data = PatrimonioApolice::with(['patrimonios', 'patrimonios.produto', 'seguradora'])->get();

        if (count($data)) {
            foreach ($data as $item) {
                $result[] = $item;
            }
        }
        return response()->success($result);
    }

    public function store(PatrimonioApoliceRequest $request)
    {
        try {
            \DB::beginTransaction();

            $model = new PatrimonioApolice;

            $model->id_empresa = $request->id_empresa;
            $model->descricao = $request->descricao;
            $model->numero = $request->numero;
            $model->data_inicio = $request->data_inicio;
            $model->data_final = $request->data_final;
            $model->valor_franquia = $request->valor_franquia;
            $model->valor_premio = $request->valor_premio;
            $model->descricao_valores = $request->descricao_valores;
            $model->motivo_cancelamento = $request->motivo_cancelamento ? $request->motivo_cancelamento : null;

            $model->save();

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

    public function update(PatrimonioApoliceRequest $request, $id)
    {
        try {
            \DB::beginTransaction();

            $model = PatrimonioApolice::find($id);

            $model->id_empresa = $request->id_empresa;
            $model->descricao = $request->descricao;
            $model->numero = $request->numero;
            $model->data_inicio = $request->data_inicio;
            $model->data_final = $request->data_final;
            $model->valor_franquia = $request->valor_franquia;
            $model->valor_premio = $request->valor_premio;
            $model->descricao_valores = $request->descricao_valores;
            $model->motivo_cancelamento = $request->motivo_cancelamento ? $request->motivo_cancelamento : null;

            $model->update();

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
