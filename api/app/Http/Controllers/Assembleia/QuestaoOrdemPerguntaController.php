<?php


namespace App\Http\Controllers\Assembleia;


use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaPergunta;
use App\Models\Assembleia\AssembleiaQuestaoOrdemPergunta;
use Illuminate\Http\Request;

class QuestaoOrdemPerguntaController
{
    public function index ($idAssembleia)
    {
        return response()->success(AssembleiaQuestaoOrdemPergunta::where('id_assembleia',$idAssembleia)->get());
    }

    public function store (Request $request)
    {
        $data = $request->all();

        $assembleia = Assembleia::find($data['id_assembleia']);

        $pergunta = AssembleiaPergunta::create(['pergunta'=>$data['pergunta']]);

        $pergunta->assembleiaOpcoes()->createMany($data['alternativas']);

        $assembleia->questoesOrdensPerguntas()->create([
            'id_pergunta' => $pergunta->id,
            'votacao_data_fim' => $data['votacao_data_fim'],
            'votacao_hora_fim' => $data['votacao_hora_fim']
        ]);

        return response()->success($assembleia);
    }

    public function show ($id)
    {

    }

    public function update(Request $request, $id)
    {

    }
}