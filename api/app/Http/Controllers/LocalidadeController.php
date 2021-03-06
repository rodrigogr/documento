<?php

namespace App\Http\Controllers;

use App\Http\Requests\LocalidadeRequest;
use App\Models\Localidade;

class LocalidadeController extends Controller
{
    private $name = 'Localidade';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = Localidade::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FAE', ['name' => $this->name]));
    }

    public function locaisReservaveis()
    {
        $Data = Localidade::getLocaisReservaveis();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FAE', ['name' => $this->name]));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  LocalidadeRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(LocalidadeRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Localidade::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = Localidade::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  LocalidadeRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(LocalidadeRequest $request, $id)
    {
        $Data = Localidade::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
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
        $Data = Localidade::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function locaisPermitidos($idPessoa)
    {
        $Data = Localidade::getLocaisReservaveis();

        if ($Data) {
            $permitidos = [];
            foreach ($Data as $localidade) {
                foreach ($localidade->locaisReservaveis as $local_reservavel) {
                    if ($local_reservavel->restricao) {
                        if ($local_reservavel->restricao == 'restricao_clube') {
                            $verificaClube = $this->buscaPessoaClube($idPessoa);
                            if ($verificaClube) {
                                $permitidos[] = $local_reservavel;
                            }
                        } else {
                            $verificaAcademia = $this->buscaPessoaAcademia($idPessoa);
                            if ($verificaAcademia) {
                                $permitidos[] = $local_reservavel;
                            }
                        }
                    } else {
                        $permitidos[] = $local_reservavel;
                    }
                }
                if (!count($permitidos)) {
                    unset($localidade);
                } else {
                    unset($localidade->locaisReservaveis);
                    $localidade->locaisReservaveis = $permitidos;
                    $permitidos = [];
                }
            }

            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    private function buscaPessoaClube($idPessoa)
    {
        return \DB::connection('portaria')
            ->select('select id from clube where id_pessoa = '.$idPessoa.' and softdeleted = 0');
    }

    private function buscaPessoaAcademia($idPessoa)
    {
        return \DB::connection('portaria')
            ->select('select id from academia where id_pessoa = '.$idPessoa.' and acesso_academia = 1');
    }
}
