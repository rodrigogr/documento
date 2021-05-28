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
        $pauta = AssembleiaPauta::where('assembleia_pautas.id', $id)->get()->first();

        DB::beginTransaction();
        //Pergunta da Pauta a ser atualizada
        $pergunta = AssembleiaPergunta::where('id', $pauta->id_pergunta)
            ->update(['pergunta' => $data['pauta']]);

        //Apaga todas as alternativas da pauta para atualizar
        $delAlternativas = AssembleiaOpcao::where('id_pergunta', $data['id']);
        if ($delAlternativas) {
            try {
                $delAlternativas->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
        }
        //Insere as alternativas atualizadas da pauta
        foreach ($alternativas as $alternativa) {
            AssembleiaOpcao::create(['id_pergunta' => $data['id'], 'opcao' => $alternativa['opcao']]);
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
