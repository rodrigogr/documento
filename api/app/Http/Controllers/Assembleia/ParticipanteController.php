<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\Models\Pessoa;

class ParticipanteController extends Controller
{
    public function index()
    {
        $participantes = \DB::connection('portaria')->table('imovel')
            ->select('id as id_imovel', 'quadra', 'lote', 'peso' )
            ->where('imovel_ficticio',0)->where('softdeleted',0)
            ->get();


        foreach ($participantes as $participante)
        {
            $participante->participar = true;
        }

        return response()->success($participantes);
    }

    public function searchProcurador ($nome)
    {
        $pessoas = \DB::connection('portaria')->table('pessoa')
                    ->select('pessoa.id', 'nome', 'codigo' )
                    ->join('pessoa_permanente', 'pessoa.id', '=', 'pessoa_permanente.id_pessoa')
                    ->where('nome','like', '%'. $nome . '%')
                    ->get();
        return response()->success($pessoas);
    }
}