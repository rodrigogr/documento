<?php

namespace App\Http\Controllers;

use App\Models\Carteira;
use Illuminate\Http\Request;

class CarteiraController extends Controller
{
    private $name = 'Carteira';

    public function index(){
        $Data = Carteira::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function show($id){
        $Data = Carteira::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }
}
