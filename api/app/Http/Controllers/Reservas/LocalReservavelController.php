<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\LocalReservavelRequest;
use App\Models\Reservas\LocalReservavel;

class LocalReservavelController extends Controller
{
    private $name = 'Local Reservável';

    public function index()
    {
        $Data = LocalReservavel::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(LocalReservavelRequest $request)
    {
        try {
            $data = $request->all();
            $Data = LocalReservavel::create($data);
            return response($Data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
    }
}