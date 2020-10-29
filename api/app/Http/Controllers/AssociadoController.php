<?php

namespace App\Http\Controllers;

use App\Http\Requests\AssociadoRequest;
use App\Http\Requests\ContatoRequest;
use App\Models\Pessoa;
use App\Models\Email;
use App\Models\Telefone;

class AssociadoController extends Controller
{
    private $name = 'Associado';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = Pessoa::all()->every(10);
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  AssociadoRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(AssociadoRequest $request)
    {
//        return $request->all();
        try {
            $data = $request->all();
            $Contato = Contato::create($data);
            $data['idcontato'] = $Contato->id;
//            return $data;
            /*
            if($request->has('telefones')){
                foreach($data['telefones'] as $telefone){
                    $telefone['idcontato'] = $data['idcontato'];
                    $this->telefone_store($telefone);
                }
            }
            if($request->has('emails')){
                foreach($data['emails'] as $email){
                    $email['idcontato'] = $data['idcontato'];
                    $this->email_store($email);
                }
            }
            */
            $Data = Associado::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
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
        $Data = Pessoa::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  AssociadoRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(AssociadoRequest $request, $id)
    {
        $Data = Associado::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
                $Data->contato->update($data);
                /*
                if($request->has('telefones')){
                    foreach($data['telefones'] as $telefone){
                        $update = Telefone::find($telefone['id']);
                        $update->update($data);
                    }
                }
                if($request->has('emails')){
                    foreach($data['emails'] as $email){
                        $update = Email::findOrFail($email['id']);
                        $update->update($data);
                    }
                }
                */
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
        $Data = Associado::find($id);
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


    /**
     * Store a newly created resource in storage.
     *
     * @param  array $telefone
     * @return int id
     */
    public function telefone_store($telefone)
    {
        try {
            Telefone::create([
                'idcontato' => $telefone['idcontato'],
                'idtipo_telefone' => $telefone['idtipo_telefone'],
                'numero' => $telefone['numero']
            ]);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => 'Telefone']));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  array $email
     * @return boolean
     */
    public function email_store($email)
    {
        try {
            Email::create([
                'idcontato' => $email['idcontato'],
                'email' => $email['email'],
                'numero' => $email['notificacao']
            ]);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => 'Email']));
    }
}
