<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaOpcao;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaVotacao;
use Illuminate\Http\Request;


class PautaController extends Controller
{
    public function index()
    {
        $pautas = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_perguntas.pergunta', 'assembleia_pautas.id_pergunta')
            ->get();

        foreach ($pautas as $pauta) {
            $opcoes = AssembleiaPergunta::find($pauta->id_pergunta)->assembleiaOpcoes()->count();
            $votos = AssembleiaVotacao::where('id_pergunta', $pauta->id_pergunta)->count();

            $result[] = [
                'id' => $pauta->id,
                'pauta' => $pauta->pergunta,
                'alternativas' => $opcoes,
                'votos' => $votos
            ];
        }
        return response()->success($result);
    }

    public function show($id)
    {
        $pauta = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_perguntas.pergunta', 'assembleia_pautas.id_pergunta')
            ->where('assembleia_pautas.id', $id)
            ->get()
            ->first();

        $alternativas = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $pauta->id_pergunta)
            ->select('opcao')
            ->get();

        $votos = AssembleiaVotacao::where('id_pergunta', $pauta->id_pergunta)->count();

        $result[] = [
            'id' => $pauta->id,
            'pauta' => $pauta->pergunta,
            'alternativas' => $alternativas,
            'votos' => $votos
        ];

        return response()->success($result);
    }

    public function update(Request $request, $id)
    {
        //Atualizar Pauta
    }
}
