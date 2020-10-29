<?php

namespace App\Http\Controllers;

use App\Models\Aprovador;
use App\Http\Requests\AprovadorRequest;
use App\Models\Usuario;
use Illuminate\Http\Request;

class AprovadorController extends Controller
{
    private $name = 'Aprovador';

    public function index(Request $request)
    {
        $data = $request->all();
        if(isset($data['page'])){
            $Data = Aprovador::paginate(13);
            foreach($Data->items() as $value){
                $usuario = \App\Models\Usuario::where("id","=",$value->idusuario)->first(['id', 'login']);
                $value["usuario"] = $usuario;
            }
            return response($Data);
        } else {
            $Data = Aprovador::all();
            $result = array();
            foreach($Data as $value){
                $usuario = \App\Models\Usuario::where("id","=",$value->idusuario)->first(['id', 'login']);
                $result[] = array("aprovador"=>$value, "usuario"=>$usuario);
            }
            return response()->success($result);
        }
    }

    public function store(Request $request)
    {
        try {
            \DB::beginTransaction();
            $data = $request->all();
            $modulo_cod = array();
            $tipo = array();
            $i = 0;
            foreach ($data["modulo"] as $key => $item) {
                $modulo_cod[] = $key;
                if($item) {
                    //pegando o nome do modulo para gravar na tabela de aprovadores
                    foreach ($data["modulo_desc"] as $desc) {
                        if ($desc["cod"] === $key) {
                            $tipo[] = $desc["nome"];
                        }
                    }
                }
                $i++;
            }
            //verifica se precisa cadastrar ou atualizar permissão no módulo principal de Compras
            array_push($modulo_cod, 'compras');
            if (count($tipo)) {
                $data["modulo"] = array_add($data["modulo"], 'compras', 1);
            } else {
                $data["modulo"] = array_add($data["modulo"], 'compras', 0);
            }
            //busca os módulos específicos de compras
            $mod_sis = \DB::table('modulo_sistema')->whereIn('nome',$modulo_cod)->get();
            foreach ($mod_sis as $modulo) {
                $tinyint = ($data["modulo"][$modulo->nome]) ? 1 : 0;
                $usu_perm = \DB::table('permissao_usuario')->where('id_usuario',$data["idusuario"])->where('id_modulo',$modulo->id)->first();
                if (count($usu_perm)) {
                    \DB::table('permissao_usuario')->where('id_usuario',$data["idusuario"])->where('id_modulo',$modulo->id)
                        ->update([
                            'visualizar' => $tinyint,
                            'inserir' => $tinyint,
                            'editar' => $tinyint,
                            'excluir' => $tinyint
                        ]);
                } else {
                    \DB::table('permissao_usuario')->insert([
                        'id_usuario' => $data["idusuario"],
                        'id_modulo' => $modulo->id,
                        'visualizar' => $tinyint,
                        'inserir' => $tinyint,
                        'editar' => $tinyint,
                        'excluir' => $tinyint
                    ]);
                }
            }

            $tipo = implode(', ',$tipo);
            $aprv = Aprovador::updateOrCreate(
                ['idusuario' => $data["idusuario"]],
                ['email' => $data["email"], 'tipo' => $tipo]
            );
            \DB::commit();
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage);
        }
        return $aprv;
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = Aprovador::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  AprovadorRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(AprovadorRequest $request, $id)
    {
        $Data = Aprovador::find($id);
        $data = $request->all();
        if (count($Data)) {
            try {
            $aprovador = \App\Models\Aprovador::where([
                ['idusuario','=',$data["idusuario"]],
                ['id','!=',$id]
            ])->get();

                if(count($aprovador)==0){
               
                    $Data->update($data);
                }else{
                    return response()->error("Aprovador já cadastrado!");
                }


            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $Data = Aprovador::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }

    }
}
