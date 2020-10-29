<?php

namespace App\Http\Controllers;

use App\Models\Usuario;
use App\Http\Requests\UsuarioRequest;

class UsuarioController extends Controller
{
    private $name = 'Usuario';

    public function index(){
        $Data = Usuario::all();
        $result = array();  
        foreach($Data as $value){
            $result[] = array("id"=>$value["id"], "nome"=>$value["login"], "email" =>"filipemot@gmail.com");
        }

        return response()->success($result);
    }

    public function usuariosPessoas()
    {
        $Data = Usuario::whereHas('pessoa')
            ->with(['pessoa' => function($q) {
                $q->select('id','nome');
            }])
            ->where('ativo','s')
            ->select('id','id_pessoa_funcionario')
            ->get();
        return response()->success($Data);
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = Usuario::find($id);
        if (count($Data)) {
            $result = array("id"=>$Data["id"], "nome"=>$Data["login"], "email" =>"filipemot@gmail.com");

            return response()->success($result);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }
}