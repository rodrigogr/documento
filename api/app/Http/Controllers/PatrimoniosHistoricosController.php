<?php
namespace App\Http\Controllers;

use App\Models\PatrimonioHistorico;

class PatrimoniosHistoricosController extends PatrimoniosController
{
    public function index()
    {
        $result = [];
         $data = PatrimonioHistorico::with('patrimonio')
             ->with(['usuario' => function ($q) {
                 $q->select('id','id_categoria','id_pessoa_funcionario');
             }])
             ->get();

        if (count($data)) {
            foreach ($data as $item) {
                $result[] = $item;
            }
        }

        return response()->success($result);
    }
}
