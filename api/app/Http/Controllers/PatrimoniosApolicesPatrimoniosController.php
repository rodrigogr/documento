<?php
namespace App\Http\Controllers;

use App\Http\Requests\PatrimonioApolicePatrimonioRequest;
use Illuminate\Database\QueryException;
use App\Models\PatrimonioApolice;

class PatrimoniosApolicesPatrimoniosController extends PatrimoniosController
{
    private $name = 'Bem patrimonial';

    public function update(PatrimonioApolicePatrimonioRequest $request, $id)
    {
        try {
            if (!$id) {
                throw new \Exception('id da apólice inválido');
            }

            if (!$request->id) {
                 throw new \Exception('Selecione um patrimônio');
            }

            $model = PatrimonioApolice::find($id);

            if ($model->patrimonios()->find($request->id)) {
                throw new \Exception('O patrimônio informado já está vinculado à esta apólice');
            }

            \DB::beginTransaction();

            $model->patrimonios()->attach($request->id);

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

    public function destroy(PatrimonioApolicePatrimonioRequest $request, $id)
    {
        try {
            \DB::beginTransaction();

            $model = PatrimonioApolice::find($id);

            if (!$model->patrimonios()->find($request->id)) {
                throw new \Exception('O patrimônio informado não está vinculado à esta apólice');
            }

            $model->patrimonios()->detach($request->id);

            \DB::commit();

            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } catch (QueryException $q) {
            \DB::rollBack();
            return response()->error('Problemas ao desvincular registro! <> ' . $q->getMessage());
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }
}
