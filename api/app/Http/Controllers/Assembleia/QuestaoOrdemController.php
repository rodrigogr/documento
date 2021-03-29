<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use Illuminate\Http\Request;
use mysql_xdevapi\Exception;

class QuestaoOrdemController extends Controller
{
    public function index(int $id)
    {
        return response()->success(AssembleiaQuestaoOrdem::all());
    }

    public function store(Request $request)
    {
        try {
            DB::beginTransaction();
            $data = $request->all();
            $dataThead = $data['thead'];

            $thead = AssembleiaThead::create($dataThead);
            $thead->theadAnexos()->createMany($dataThead['anexos']);

            $assembleiaQuestaoOrdem =  AssembleiaQuestaoOrdem::create([
                'id_thead'=> $thead->id,
                'id_assembleia'=>$request->id_assembleia,
                'id_pauta' => $data['id_pauta']
            ]);
            DB::commit();
            return response()->success($assembleiaQuestaoOrdem);
        }
        catch (Exception $e)
        {
            return response()->error($e->getMessage());
        }
    }

    public function createDecisao(Request $request)
    {

    }
}