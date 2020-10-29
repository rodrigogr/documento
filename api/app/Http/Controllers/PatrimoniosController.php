<?php
namespace App\Http\Controllers;

use App\Models\PatrimonioHistorico;

abstract class PatrimoniosController extends Controller
{
    protected function gravaHistorico($status, $id_patrimonio)
    {
        try {
            \DB::beginTransaction();

             $model = new PatrimonioHistorico;

            $model->id_patrimonio = $id_patrimonio;
            $model->status = $status;
            $model->id_usuario = 1; // TODO: buscar o usuário logado.
            $model->data_hora = date('Y-m-d H:i:s');

            $model->save();

            \DB::commit();

            return true;
        } catch (QueryException $q ) {
            \DB::rollBack();
            throw new PatrimonioException('Problemas ao gravar histórico! <> ' . $q->getMessage());
        } catch (\Exception $e) {
            \DB::rollBack();
            throw new PatrimonioException($e->getMessage());
        }
    }
}