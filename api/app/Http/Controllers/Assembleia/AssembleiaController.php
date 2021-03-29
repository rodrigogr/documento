<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\Http\Requests\Assembleia\AssembleiaRequest;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaDiscussao;
use App\models\Assembleia\AssembleiaDocumento;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use Illuminate\Support\Facades\DB;
use League\Flysystem\Exception;

class AssembleiaController extends Controller
{
    public function index()
    {
        return response()->success(Assembleia::orderBy('id','DESC')->get());
    }

    public function store(AssembleiaRequest $request)
    {
        $data = $request->all();

        try
        {
            DB::beginTransaction();
                $assembleia = Assembleia::create($data);
                $assembleia->documentos()->createMany($data['documentos']);
                foreach ($data['pautas'] as $pauta)
                {
                    $pergunta = AssembleiaPergunta::create(['pergunta'=> $pauta['pergunta']]);
                    $pergunta->assembleiaOpcoes()->createMany($pauta['alternativas']);
                    $assembleia->pautas()->create(['id_pergunta' => $pergunta->id]);
                }
                $assembleia->participantes()->createMany($data['participantes']);
            DB::commit();
            return response()->success($assembleia);

        } catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }
    }
    public function update(AssembleiaRequest $request, $id)
    {
        $data = $request->all();
    }

    public function show($id)
    {
        $assembleia = Assembleia::where('id', $id)->with('documentos')->get();

        return response()->success($assembleia);
    }

    public function resumo($id)
    {
        $assembleia = Assembleia::where('id', $id)->with('documentos')->get();

        $questoes = AssembleiaQuestaoOrdem::where('id_assembleia', $id)->count();

        $encaminhamentos = AssembleiaEncaminhamento::where('id_assembleia', $id)->count();

        $topicos = AssembleiaDiscussao::where('id_assembleia', $id)->with('theads')->count();

        $result = [
            'assembleia' => $assembleia,
            'questoesOrdem'=> $questoes,
            'encaminhamentos' => $encaminhamentos,
            'topicos' => $topicos,
            'comentarios' => 0,
            'unidadesAptas' => 0,
            'unidadesInteragiram' => 0,
            'unidadesVotaram' => 0
        ];

        return response()->success($result);
    }




}