<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaOpcao;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaVotacao;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class PautaController extends Controller
{
    public function show($id)
    {
        $pauta = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_perguntas.pergunta', 'assembleia_pautas.id_pergunta')
            ->where('assembleia_pautas.id', $id)
            ->get()
            ->first();

        $alternativas = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $pauta->id_pergunta)
            ->select('id', 'opcao')
            ->get();

        $result[] = [
            'id' => $pauta->id,
            'pauta' => $pauta->pergunta,
            'alternativas' => $alternativas
        ];

        return response()->success($result);
    }

    public function update(Request $request, $id)
    {
        $data = $request->all();
        $alternativas = $data['alternativas'];

        $pauta = AssembleiaPauta::where('assembleia_pautas.id', $id)
            ->get()
            ->first();

        DB::beginTransaction();
        AssembleiaPergunta::where('id', $pauta->id_pergunta)
            ->update(['pergunta' => $data['pauta']]);

        $contador = 1;
        foreach ($alternativas as $alternativa) {
            AssembleiaOpcao::where('id', $contador)
                ->where('id_pergunta', $pauta->id_pergunta)
                ->update(['opcao' => $alternativa['opcao']]);
            $contador++;
        }
        DB::commit();
    }

    public function listPautasAssembleia($idAssembleia)
    {
        $pautas = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_pautas.numero as pauta', 'assembleia_perguntas.pergunta')
            ->where('id_assembleia', $idAssembleia)->get();

        return response()->success($pautas);
    }
}
