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

        $result = [
            'id_pauta' => $pauta->id,
            'id_pergunta' => $pauta->id_pergunta,
            'pauta' => $pauta->pergunta,
            'alternativas' => $alternativas
        ];

        return response()->success($result);
    }

    public function update(Request $request, $id)
    {
        $data = $request->all();

        $pauta = AssembleiaPauta::find($id);

        if(!$pauta)
        {
            return response()->error('Pauta não encontrada.');
        }
        try
        {
            DB::beginTransaction();

            //Pergunta da Pauta a ser atualizada
            $pergunta = AssembleiaPergunta::where('id', $pauta->id_pergunta)
                ->update(['pergunta' => $data['pauta']]);


            foreach ($data['alternativas'] as $alternativa)
            {
                $opcao = AssembleiaOpcao::find($alternativa['id']);

                if ($opcao)
                {
                    $opcao->update($alternativa);
                }
                else
                {
                    AssembleiaOpcao::create(['opcao'=> $alternativa['opcao'], 'id_pergunta' => $pauta->id_pergunta]);
                }
            }

            DB::commit();

            return response()->success($pauta);
        } catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }
}
    public function listPautasAssembleia($idAssembleia)
    {
        $pautas = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_pautas.numero as pauta', 'assembleia_perguntas.pergunta')
            ->where('id_assembleia', $idAssembleia)->get();

        return response()->success($pautas);
    }
}
