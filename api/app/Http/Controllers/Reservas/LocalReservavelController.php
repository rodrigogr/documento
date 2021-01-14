<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\LocalReservavelRequest;
use App\Models\Reservas\LocalReservavel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LocalReservavelController extends Controller
{
    private $name = 'Local Reservável';

    public function index()
    {
        $Data = LocalReservavel::complete();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(LocalReservavelRequest $request)
    {
        //$data = $request->except('_token');
        try {
            $data = $request->all();
//            $local = LocalReservavel::create($data);

//            if ($local->id) {
                $arrayInsert = [];
                foreach ($data["periodo"] as $key => $periodo) {
                    foreach ($periodo as $item) {
                        $arrPeriodo = ['id_reserva' => 1, 'dia_semana' => $key, 'hora_ini' => $item["hora_ini"], 'hora_fim' => $item["hora_fim"], 'valor' => $item["valor"]];
                        if ($item["hora_ini"]) {
                            array_push($arrayInsert, $arrPeriodo);
                        }
                    }
                }

                $myItems = [
                    ['id_reserva'=>1,'dia_semana'=>'seg', 'hora_ini' => '10:20', 'hora_fim' => '15:00', 'valor' => 20.00],
                    ['id_reserva'=>2,'dia_semana'=>'ter', 'hora_ini' => '10:20', 'hora_fim' => '15:00', 'valor' => 20.00],
                    ['id_reserva'=>3,'dia_semana'=>'qua', 'hora_ini' => '10:20', 'hora_fim' => '15:00', 'valor' => 20.00]
                ];


                DB::table("periodo_local_reservavel")->insert($arrayInsert);

                echo "<pre>";
                print_r($myItems);
                print_r($arrayInsert);
                exit();


//            }

        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function show($id)
    {
        $Data = LocalReservavel::find($id);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }


}