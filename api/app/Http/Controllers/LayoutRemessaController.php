<?php

namespace App\Http\Controllers;

use App\Models\LayoutRemessa;
use Illuminate\Http\Request;

class LayoutRemessaController extends Controller
{
    private $name = 'Layout Remessa';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = LayoutRemessa::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = LayoutRemessa::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }
}
