<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\ProcessoQuestaoOrdem;
use App\models\Assembleia\TheadAnexo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use mysql_xdevapi\Exception;

class QuestaoOrdemController extends Controller
{
    public function index(int $id)
    {
        return response()->success(AssembleiaQuestaoOrdem::all());
    }

    /*
    * Cria uma questão de ordem na assembleia
    * */
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

    /*
     *  Detalhar a questão de ordem
     *
     * */
    public function detalhar ($idQuestaoOrdem)
    {
//        $questaoOrdem = DB::table('assembleia_questoes_ordens', 'assembleia_questoes_ordens.id', $idQuestaoOrdem)
//            ->get()->first();
        $questaoOrdem = AssembleiaQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
            'assembleia_questoes_ordens.id_thead')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->select('assembleia_questoes_ordens.id', 'assembleia_theads.titulo','assembleia_theads.texto', 'pessoa.url_foto as foto',
            'pessoa.nome as autor', 'assembleia_theads.id as id_thead', 'assembleia_questoes_ordens.id_pauta')
            ->where('assembleia_questoes_ordens.id', $idQuestaoOrdem)->get()->first();

        $questaoOrdem['anexos'] = DB::table('assembleia_theads_anexos')
            ->where('assembleia_theads_anexos.id_thead', $questaoOrdem->id_thead)
            ->select('file')
            ->get();

//        // Falta os campos numero_pauta | total_pauta
        $questaoOrdem['pauta'] = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->where('assembleia_pautas.id', $questaoOrdem->id_pauta)
            ->select('assembleia_pautas.id','assembleia_perguntas.pergunta')
            ->get()->first();

        $questaoOrdem['processos'] = ProcessoQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
            'processos_questao_ordem.id_thead')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->select('processos_questao_ordem.tipo', 'processos_questao_ordem.status', 'assembleia_theads.titulo','assembleia_theads.texto', 'pessoa.url_foto as foto',
                'pessoa.nome as autor', 'assembleia_theads.id as id_thead')
            ->where('id_questao_ordem', $questaoOrdem->id)->get();

        foreach ($questaoOrdem['processos'] as $processo)
        {
            $processo['anexos'] = DB::table('assembleia_theads_anexos')
                ->where('assembleia_theads_anexos.id_thead', $processo->id_thead)
                ->select('file')
                ->get();
        }

        return response()->success($questaoOrdem);
    }

    /*
     *  Cria uma decisão da questão de ordem
     *
     * */
    public function createDecisao(Request $request)
    {
        // TODO Decisão da questão de ordem
        $data = $request->all();

        $usuario = DB::table('bioacesso_portaria.pessoa')
            ->where('pessoa.id', $data['id_pessoa'])
            ->get()
            ->first();

        try {
            DB::beginTransaction();
            $novaThead = AssembleiaThead::create([
                'titulo' => "Decisão",
                'texto' => $data['fundamentacao'],
                'id_pessoa' => $usuario->id
            ]);

            $decisao = ProcessoQuestaoOrdem::create([
                'id_thead' => $novaThead->id,
                'id_questao_ordem' => $data['id_questao_ordem'],
                'tipo'=>'decisao',
                'status' => $data['status']
            ]);
            DB::commit();
        }
        catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success($decisao, $novaThead->texto);
    }

    /*
     *  Recorre uma decisão da questão de ordem
     *
     * */
    public function recorrerDecisao(Request $request)
    {
        // TODO Recorre uma decisão da questão de ordem
        $data = $request->all();

        $usuario = DB::table('bioacesso_portaria.pessoa')
            ->where('pessoa.id', $data['id_pessoa'])
            ->get()
            ->first();

        try {
            DB::beginTransaction();
            $novaThead = AssembleiaThead::create([
                'titulo' => "Recurso",
                'texto' => $data['fundamentacao'],
                'id_pessoa' => $usuario->id
            ]);

            foreach ($data['anexos'] as $anexo)
            {
                TheadAnexo::create([
                    'file' => $anexo['file'],
                    'id_thead' => $novaThead->id
                ]);
            }

            $decisao = ProcessoQuestaoOrdem::create([
                'id_thead' => $novaThead->id,
                'id_questao_ordem' => $data['id_questao_ordem'],
                'tipo'=>'recurso'
            ]);

            DB::commit();
        }
        catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success($decisao);
    }
}