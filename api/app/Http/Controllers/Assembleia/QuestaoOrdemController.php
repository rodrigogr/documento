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
use Exception;

class QuestaoOrdemController extends Controller
{
    public function index($id)
    {
        return response()->success(AssembleiaQuestaoOrdem::all());
    }

    /*
    * Cria uma questão de ordem na assembleia
    * */
    public function store(Request $request)
    {
        try
        {

            DB::beginTransaction();

            $data = $request->all();

            $dataThead = $data['thead'];

            $assembleia = Assembleia::find($data['id_assembleia']);


            if(!$assembleia)
            {
                return response()->error('Assembleia não existe!');
            }

            if ($assembleia->status == 'agendada')
            {
                return response()->error('O envio de questões de ordem não foi inicicada, pois a assembleia ainda está agendada');
            }

            if($assembleia->status != 'andamento')
            {
                return response()->error('O envio de questões de ordem foi encerrado, pois a votação já foi iniciada.');
            }

            if($assembleia->envios_questao_ordem)
            {
                return response()->error('O envio de questões de ordem foi encerrado manualmente.');
            }

            $questoesPessoa = AssembleiaQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
                'assembleia_questoes_ordens.id_thead')
                ->where('assembleia_theads.id_pessoa', $dataThead['id_pessoa'])
                ->where('assembleia_questoes_ordens.id_assembleia', $assembleia->id)
                ->count();

            if ($questoesPessoa >= 2)
            {
                return response()->error('Você já atingiu o limite de envio de 02 questões de ordem nesta assembleia.');
            }


            $thead = AssembleiaThead::create($dataThead);

            if (isset($dataThead['anexos']))
            {
                $thead->theadAnexos()->createMany($dataThead['anexos']);
            }

            $assembleiaQuestaoOrdem =  AssembleiaQuestaoOrdem::create([
                'id_thead'=> $thead->id,
                'id_assembleia'=>$data['id_assembleia'],
                'id_pauta' => $data['id_pauta'],
                ''
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

        $questaoOrdem = AssembleiaQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
            'assembleia_questoes_ordens.id_thead')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->select('assembleia_questoes_ordens.id', 'assembleia_theads.titulo','assembleia_theads.texto',
                'pessoa.url_foto as foto', 'pessoa.nome as autor','pessoa.id as id_pessoa',
                'assembleia_theads.id as id_thead', 'assembleia_questoes_ordens.id_pauta',
                'assembleia_questoes_ordens.status')
            ->where('assembleia_questoes_ordens.id', $idQuestaoOrdem)->get()->first();

        $questaoOrdem['anexos'] = DB::table('assembleia_theads_anexos')
            ->where('assembleia_theads_anexos.id_thead', $questaoOrdem->id_thead)
            ->select('file')
            ->get();

//        // Falta os campos numero_pauta | total_pauta
        $questaoOrdem['pauta'] = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta',
            'assembleia_perguntas.id')
            ->where('assembleia_pautas.id', $questaoOrdem->id_pauta)
            ->select('assembleia_pautas.id','assembleia_perguntas.pergunta', 'assembleia_pautas.numero')
            ->get()->first();

        $questaoOrdem['processos'] = ProcessoQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
            'processos_questao_ordem.id_thead')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->select('processos_questao_ordem.tipo', 'processos_questao_ordem.status', 'assembleia_theads.titulo',
                'assembleia_theads.texto', 'pessoa.url_foto as foto', 'pessoa.nome as autor',
                'assembleia_theads.id as id_thead')
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

        $data = $request->all();

        try {

            $questao = AssembleiaQuestaoOrdem::find($data['id_questao_ordem']);

            if(!$questao)
            {
                return response()->error('Questão de ordem não existe!');
            }

            if($questao->status != 'Pendente de decisão' && $questao->status != 'Pendente de decisão de recurso')
            {
                return response()->error('Decisão já realizada!');
            }

            DB::beginTransaction();
            $novaThead = AssembleiaThead::create([
                'titulo' => "Decisão",
                'texto' => $data['fundamentacao'],
                'id_pessoa' => $data['id_pessoa']
            ]);

            $decisao = ProcessoQuestaoOrdem::create([
                'id_thead' => $novaThead->id,
                'id_questao_ordem' => $data['id_questao_ordem'],
                'tipo'=>'decisao',
                'status' => $data['status']
            ]);

            if ($data['status'] == 'deferida' && $questao->status == 'Pendente de decisão')
            {
                $questao->status = 'Deferida';
            }
            else if ($data['status'] == 'deferida' && $questao->status == 'Pendente de decisão de recurso')
            {
                $questao->status = 'Recurso deferido';
            }
            else if ($data['status'] == 'indeferida' && $questao->status == 'Pendente de decisão de recurso')
            {
                $questao->status = 'Recurso indeferido';
            }
            else
            {
                $questao->status = 'Indeferida';
            }

            $questao->update();

            DB::commit();
        }
        catch (Exception $e)
        {
            return response()->error($e->getMessage());
        }
        return response()->success($decisao, $novaThead->texto);
    }

    /*
     *  Recorre uma decisão da questão de ordem
     *
     * */
    public function recorrerDecisao(Request $request)
    {
        $data = $request->all();

        try {

            $questao = AssembleiaQuestaoOrdem::find($data['id_questao_ordem']);

            if (!$questao)
            {
                return response()->error('Questão de ordem não existe!');
            }

            $assembleia = Assembleia::find($questao->id_assembleia);

            if(!$assembleia)
            {
                return response()->error('Assembleia não existe!');
            }

            if($assembleia->status != 'andamento')
            {
                return response()->error('O envio de questões de ordem foi encerrado, pois a votação já foi iniciada.');
            }
            
            if($questao->status != 'Indeferida')
            {
                return response()->error('Não cabe recurso na questão de Ordem!');
            }

            DB::beginTransaction();

            $novaThead = AssembleiaThead::create([
                'titulo' => "Recurso",
                'texto' => $data['fundamentacao'],
                'id_pessoa' => $data['id_pessoa']
            ]);

            if (isset($data['anexos']))
            {
                foreach ($data['anexos'] as $anexo) {
                    TheadAnexo::create([
                        'file' => $anexo['file'],
                        'id_thead' => $novaThead->id
                    ]);
                }
            }
            $decisao = ProcessoQuestaoOrdem::create([
                'id_thead' => $novaThead->id,
                'id_questao_ordem' => $data['id_questao_ordem'],
                'tipo'=>'recurso'
            ]);

            $questao->status = 'Pendente de decisão de recurso';

            $questao->update();

            DB::commit();

            return response()->success($decisao);
        }
        catch (Exception $e) {
            return response()->error($e->getMessage());
        }

    }

    public function encerrarEnviosQuestaoOrdem($id)
    {
        try
        {
            $assembleia = Assembleia::find($id);
            $assembleia->envios_questao_ordem = date('Y-m-d H:i:s');
            $assembleia->update();
            return response()->success('Envios Encerrados!');
        }
        catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }

    public function listQuestaoOrdemAplicativoPorAssembleia($idAssembleia)
    {
        $questoesOrdem = AssembleiaQuestaoOrdem::join('assembleia_pautas', 'assembleia_questoes_ordens.id_pauta', '=', 'assembleia_pautas.id')
            ->join('assembleia_theads', 'assembleia_questoes_ordens.id_thead', '=', 'assembleia_theads.id')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', '=', 'pessoa.id')
            ->join('usuario','assembleia_theads.id_pessoa', '=', 'usuario.id_pessoa_bioacesso')
            ->select('assembleia_questoes_ordens.id','assembleia_questoes_ordens.created_at as data_hora',
                'assembleia_questoes_ordens.status as status', 'pessoa.nome', 'usuario.url_img_perfil', 'assembleia_pautas.numero as pauta', 'assembleia_theads.titulo' )
            ->where('assembleia_questoes_ordens.id_assembleia', $idAssembleia)
            ->orderBy('assembleia_questoes_ordens.created_at','desc')
            ->get();

        return response()->success($questoesOrdem);
    }
}