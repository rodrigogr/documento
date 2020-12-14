<?php
namespace Source\Reservas\Controllers;

use App\Http\Controllers\Controller;
use Source\Reservas\Models\LocalReservavel;

class LocalReservavelController  extends Controller
{
    private $name = 'Localidade Condomínio';

    public function index()
    {
        $Data = LocalReservavel::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }
}