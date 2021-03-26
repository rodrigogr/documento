<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use Illuminate\Http\Request;

class QuestaoOrdemController extends Controller
{
    public function index(int $id)
    {
        return response()->success(AssembleiaQuestaoOrdem::all());
    }

    public function store(Request $request)
    {
        $data = $request->all();
        $dataThead = $data['thead'];

        $thead = AssembleiaThead::create($dataThead);
        $thead->theadAnexos()->createMany($dataThead['anexos']);

        $assembleiaQuestaoOrdem =  AssembleiaQuestaoOrdem::create([
            'id_thead'=> $thead->id,
            'id_assembleia'=>$request->id_assembleia,
            'id_pauta' => $data['id_pauta']
        ]);
        return response()->success($assembleiaQuestaoOrdem);
    }

    public function createDecisao(Request $request)
    {

    }
}