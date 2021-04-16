<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
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
        // TODO Detalhar questão de ordem

        $questaoOrdem = DB::table('assembleia_questoes_ordens', 'assembleia_questoes_ordens.id', $idQuestaoOrdem)
            ->get()->first();

        // Falta os campos numero_pauta | total_pauta
        $pautaDiscutida = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->where('assembleia_pautas.id', $questaoOrdem->id_pauta)
            ->select('assembleia_pautas.id as id_pauta','assembleia_perguntas.pergunta')
            ->get()->first();

        $anexos = DB::table('assembleia_theads_anexos')
            ->where('assembleia_theads_anexos.id_thead', $questaoOrdem->id_thead)
            ->select('file')
            ->get();

        $pautaDiscutida['questao_ordem'] = Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa',
            'pessoa.id')
            ->where('assembleia_theads.id', $questaoOrdem->id_thead)
            ->select('assembleia_theads.created_at as data_hora', 'pessoa.nome as autor', 'pessoa.url_foto as ulr_foto_autor',
                'assembleia_theads.titulo', 'assembleia_theads.texto')
            ->get();

        $pautaDiscutida['questao_ordem']['anexos'] = $anexos;

        $decisao =  Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->join('processos_questao_ordem', 'assembleia_theads.id', 'processos_questao_ordem.id_thead')
            ->where('processos_questao_ordem.id_questao_ordem', $questaoOrdem->id)
            ->where('processos_questao_ordem.tipo', 'decisao')
            ->select('processos_questao_ordem.created_at as data_hora', 'processos_questao_ordem.status', 'pessoa.nome as autor',
              'pessoa.url_foto as ulr_foto_autor', 'assembleia_theads.texto')
            ->get()
            ->first();

        if ($decisao)
        {
            $pautaDiscutida['decisao'] = $decisao;
        }

        $recurso =  Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->join('processos_questao_ordem', 'assembleia_theads.id', 'processos_questao_ordem.id_thead')
            ->where('processos_questao_ordem.id_questao_ordem', $questaoOrdem->id)
            ->where('processos_questao_ordem.tipo', 'recurso')
            ->select('processos_questao_ordem.created_at as data_hora', 'processos_questao_ordem.status', 'pessoa.nome as autor',
                'pessoa.url_foto as ulr_foto_autor', 'assembleia_theads.texto')
            ->get()
            ->first();

        if ($recurso)
        {
            $pautaDiscutida['recurso'] = $recurso;
        }

        return response()->success($pautaDiscutida);
    }

    /*
     *  Cria uma decisão da questão de ordem
     *
     * */
    public function createDecisao(Request $request)
    {
        // TODO Decisão da questão de ordem
    }

    /*
     *  Recorre uma decisão da questão de ordem
     *
     * */
    public function recorrerDecisao(Request $request)
    {
        // TODO Recorre uma decisão da questão de ordem
    }
}