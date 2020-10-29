<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;

class EmpresaController extends Controller
{
    private $name = 'Fornecedor';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response()->success(Empresa::orderBy('nome_fantasia')->select('id','nome_fantasia')->get());
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = Empresa::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function filter(Request $request)
    {
        $dados = $request->all();
        $empresa = Empresa::orderBy('nome_fantasia')->select('id','nome_fantasia')->where('nome_fantasia','like','%'.$dados["q"].'%')->take(20)->get();
        return $empresa;
    }
}
