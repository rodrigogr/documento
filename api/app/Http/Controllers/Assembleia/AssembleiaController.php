<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\Http\Requests\Assembleia\AssembleiaRequest;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaDiscussao;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaParticipante;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaPost;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\AssembleiaVotacao;
use Illuminate\Support\Facades\DB;

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
            DB::rollback();
            \Log::critical('Error store assembleia - '. $e->getMessage());
            return response()->error($e->getMessage());
        }
    }
    public function update(AssembleiaRequest $request, $id)
    {
        $data = $request->all();

        $assembleia = Assembleia::find($id);

        if($assembleia)
        {
            try
            {
                $assembleia->update($data);

                foreach ($data['documentos'] as $documento)
                {
                    if (is_null($documento['id']))
                    {
                        $assembleia->documentos()->create($documento);
                    }
                }

                foreach ($data['pautas'] as $item)
                {
                    if (is_null($item['id']))
                    {
                        $pergunta = AssembleiaPergunta::create(['pergunta'=> $item['pergunta']]);
                        $pergunta->assembleiaOpcoes()->createMany($item['alternativas']);
                        $assembleia->pautas()->create(['id_pergunta' => $pergunta->id]);
                    }
                    else
                    {
                        $pauta = AssembleiaPauta::find($item['id']);

                        if($pauta)
                        {
                            AssembleiaPergunta::where('id', $pauta->id_pergunta)->update(['pergunta'=> $item['pergunta']]);
                            // update alternatinas
                        }
                    }
                }

                // update participantes

                return response()->success($assembleia);

            } catch (\Exception $e)
            {
                return response()->error('Error :'. $e->getMessage());
            }
        }
        else
        {
            return response()->error('Assembleia não encontrada.');
        }

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

        $topicos = AssembleiaThead::join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
            ->where('assembleia_discussoes.id_assembleia', $id)->count();

        $comentarios = AssembleiaPost::join('assembleia_theads', 'assembleia_posts.id_thead', '=', 'assembleia_theads.id')
            ->join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
            ->where('assembleia_discussoes.id_assembleia', $id)->count();

        $participantes = AssembleiaParticipante::where('id_assembleia', $id)->count();

        $result = [
            'assembleia' => $assembleia,
            'questoesOrdem'=> $questoes,
            'encaminhamentos' => $encaminhamentos,
            'topicos' => $topicos,
            'comentarios' => $comentarios,
            'unidadesAptas' => $participantes,
            'unidadesInteragiram' => 0,
            'unidadesVotaram' => 0
        ];

        return response()->success($result);
    }

    public function discussoes ($id)
    {
        $pautasDiscutidas = AssembleiaDiscussao::join('assembleia_pautas', 'assembleia_discussoes.id_pauta', '=', 'assembleia_pautas.id')
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->where('assembleia_discussoes.id_assembleia', $id)
            ->groupBy('assembleia_discussoes.id_pauta')->get();

        $numeroPauta = 1;
        $result = array();
        foreach ($pautasDiscutidas as $pautaDiscutida)
        {
            $topicos = AssembleiaThead::join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
                ->where('assembleia_discussoes.id_pauta', $pautaDiscutida->id_pauta)->count();

            $comentarios = AssembleiaPost::join('assembleia_theads', 'assembleia_posts.id_thead', '=', 'assembleia_theads.id')
                ->join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
                ->where('assembleia_discussoes.id_pauta', $pautaDiscutida->id_pauta)->count();

            $result[] = [
                'id_pauta' => $pautaDiscutida->id_pauta,
                'pauta' => $numeroPauta,
                'titulo' => $pautaDiscutida->pergunta,
                'topicos' => $topicos,
                'comentarios' => $comentarios,
                'ultima_interacao' => '2021-03-30 01:41'
            ];

            $numeroPauta ++;
        }

        return response()->success($result);
    }

    public function questoesOrdem ($id)
    {
        $questoesOrdem = AssembleiaQuestaoOrdem::join('assembleia_pautas', 'assembleia_questoes_ordens.id_pauta', '=', 'assembleia_pautas.id')
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->join('assembleia_theads', 'assembleia_questoes_ordens.id_thead', '=', 'assembleia_theads.id')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', '=', 'pessoa.id')
            ->select('assembleia_questoes_ordens.id as id_questao','assembleia_questoes_ordens.created_at as data_hora',
                    'assembleia_questoes_ordens.status as status', 'pessoa.nome', 'assembleia_perguntas.pergunta as pauta', 'assembleia_theads.titulo' )
            ->where('assembleia_questoes_ordens.id_assembleia', $id)->get();

        return response()->success($questoesOrdem);
    }

    public function encaminhamentos ($id)
    {
        $ecaminhamentos = AssembleiaEncaminhamento::join('assembleia_pautas', 'assembleia_encaminhamentos.id_pauta', '=', 'assembleia_pautas.id')
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->join('assembleia_theads', 'assembleia_encaminhamentos.id_thead', '=', 'assembleia_theads.id')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', '=', 'pessoa.id')
            ->select('assembleia_encaminhamentos.id as id_encaminhamento','assembleia_encaminhamentos.created_at as data_hora',
                'assembleia_encaminhamentos.status', 'pessoa.nome', 'assembleia_perguntas.pergunta as pauta', 'assembleia_theads.titulo', 'assembleia_encaminhamentos.apoio' )
            ->where('assembleia_encaminhamentos.id_assembleia', $id)->get();

        return response()->success($ecaminhamentos);
    }

    public function pautas ($id)
    {
        $pautas = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->select('assembleia_pautas.id', 'assembleia_perguntas.pergunta', 'assembleia_pautas.id_pergunta')
            ->where('id_assembleia', $id)->get();

        $result = array();
        foreach ($pautas as $pauta)
        {

            $opcoes = AssembleiaPergunta::find($pauta->id_pergunta)->assembleiaOpcoes()->count();
            $votos = AssembleiaVotacao::where('id_pergunta', $pauta->id_pergunta)->count();

            $result[] = [
                'id'=> $pauta->id,
                'status' => 'aguardando inicio',
                'pauta' => $pauta->pergunta,
                'alternativas' => $opcoes,
                'votos' => $votos
            ];

        }

        return response()->success($result);
    }

    public function participantes ($id)
    {
        $participantes = AssembleiaParticipante::join('bioacesso_portaria.imovel','assembleia_participantes.id_imovel', '=','imovel.id')
            ->leftJoin('bioacesso_portaria.pessoa','assembleia_participantes.id_procurador', '=', 'pessoa.id')
            ->select('imovel.id as id_imovel', 'quadra', 'lote', 'logradouro', 'numero', 'peso', 'pessoa.nome as produrador', 'pessoa.id as id_procurador')
            ->where('id_assembleia', $id)->get();

        return response()->success($participantes);
    }

}