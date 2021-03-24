<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaEncaminhamento;
use Illuminate\Http\Request;

class EncaminhamentoController extends Controller
{
    public function index()
    {
        return response()->success(AssembleiaEncaminhamento::all());
    }

    public function store(Request $request){

        return response()->json(AssembleiaEncaminhamento::create($request->all()),201);
    }
}