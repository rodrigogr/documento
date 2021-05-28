<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\Http\Requests\Assembleia\AssembleiaRequest;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaDiscussao;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaOpcao;
use App\models\Assembleia\AssembleiaParticipante;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaPost;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\AssembleiaVotacao;
use App\Models\Condominio;
use App\Models\Imovel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use function foo\func;

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


            foreach ($data['pautas'] as $key => $pauta)
            {
                $i = $key +1;

                $nuermoPauta = $i > 9 ? $i : 0 . $i;

                $pergunta = AssembleiaPergunta::create(['pergunta'=> $pauta['pergunta']]);
                $pergunta->assembleiaOpcoes()->createMany($pauta['alternativas']);
                $assembleia->pautas()->create([
                    'id_pergunta' => $pergunta->id,
                    'numero'=> 'Pauta ' . $nuermoPauta
                ]);
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
                    if (!isset($documento['id']))
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
        $assembleia = Assembleia::find($id);

        $assembleia['pautas'] = $assembleia->pautas()
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->get();

        $participantes = AssembleiaParticipante::join('bioacesso_portaria.imovel','assembleia_participantes.id_imovel', '=','imovel.id')
            ->leftJoin('bioacesso_portaria.pessoa','assembleia_participantes.id_procurador', '=', 'pessoa.id')
            ->select('imovel.id as id_imovel', 'quadra', 'lote', 'logradouro', 'numero', 'peso_voto', 'pessoa.nome as produrador', 'pessoa.id as id_procurador')
            ->where('id_assembleia', $id)->get();

        foreach ($participantes as $participante)
        {
            $participante['participar'] = true;
        }

        $assembleia['participantes'] = $participantes;

        foreach ($assembleia['pautas'] as $key => $pauta)
        {
            $opcoes = AssembleiaOpcao::where('id_pergunta', $pauta['id_pergunta'])->get();
            $assembleia['pautas'][$key]['alternativas'] = $opcoes;
        }

        return response()->success($assembleia);
    }

    public function resumo($id)
    {
        $assembleia = Assembleia::find($id);

        $questoes = AssembleiaQuestaoOrdem::where('id_assembleia', $id)->count();

        $encaminhamentos = AssembleiaEncaminhamento::where('id_assembleia', $id)->count();

        $topicos = AssembleiaThead::join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
            ->where('assembleia_discussoes.id_assembleia', $id)->count();

        $comentarios = AssembleiaPost::join('assembleia_theads', 'assembleia_posts.id_thead', '=', 'assembleia_theads.id')
            ->join('assembleia_discussoes', 'assembleia_discussoes.id_thead', '=', 'assembleia_theads.id')
            ->where('assembleia_discussoes.id_assembleia', $id)->count();

        $participantes = AssembleiaParticipante::where('id_assembleia', $id)->count();

        $imoveis = Imovel::where('imovel_ficticio',0)
            ->where('softdeleted',0)
            ->count();

        $iteragiram = ($questoes + $encaminhamentos + $topicos + $comentarios);

        $votaram = AssembleiaVotacao::where('id_assembleia', $id)->count();

        $result = [
            'assembleia' => $assembleia,
            'questoesOrdem'=> $questoes,
            'encaminhamentos' => $encaminhamentos,
            'topicos' => $topicos,
            'comentarios' => $comentarios,
            'unidadesAptas' => $participantes,
            'unidadesInteragiram' => $iteragiram,
            'unidadesVotaram' => $votaram,
            'totalUnidades' => $imoveis
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
            ->join('assembleia_theads', 'assembleia_questoes_ordens.id_thead', '=', 'assembleia_theads.id')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', '=', 'pessoa.id')
            ->select('assembleia_questoes_ordens.id','assembleia_questoes_ordens.created_at as data_hora',
                    'assembleia_questoes_ordens.status as status', 'pessoa.nome', 'assembleia_pautas.numero as pauta', 'assembleia_theads.titulo' )
            ->where('assembleia_questoes_ordens.id_assembleia', $id)->get();

        return response()->success($questoesOrdem);
    }

    public function encaminhamentos ($id)
    {
        $ecaminhamentos = AssembleiaEncaminhamento::join('assembleia_pautas', 'assembleia_encaminhamentos.id_pauta', '=', 'assembleia_pautas.id')
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->join('assembleia_theads', 'assembleia_encaminhamentos.id_thead', '=', 'assembleia_theads.id')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', '=', 'pessoa.id')
            ->select('assembleia_encaminhamentos.id','assembleia_encaminhamentos.created_at as data_hora',
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
        $participantes = DB::select("
                select 
                    i.id as id_imovel,
                    quadra, 
                    lote, 
                    peso_voto,
                    (
                        select 
                            ap.id
                        from assembleia_participantes ap 
                        where ap.id_imovel = i.id and id_assembleia = $id) as id_participante
                from bioacesso_portaria.imovel i 
                where 
                      imovel_ficticio  = 0 and softdeleted  = 0
            ");

        return response()->success($participantes);
    }

    public function listaAssembleiasUsuario()
    {
        $assembleias = Assembleia::withCount('pautas')->orderBy('data_inicio')->get();
        return $assembleias;
    }

    public function getAssembleiaDetalhadaUsuario ($id, $idPessoa)
    {
        $assembleia = Assembleia::find($id);

        if(!$assembleia)
        {
            return response()->error('Assembleia não encontrada');
        }

        if ($assembleia->status != 'encerrada')
        {
            $assembleia['pautas'] = $assembleia->pautas()
                ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
                ->select('assembleia_pautas.id', 'pergunta', 'assembleia_perguntas.id as id_pergunta' )
                ->get();

            foreach ($assembleia['pautas'] as $key => $pauta)
            {
                $opcoes = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $pauta['id_pergunta'])
                    ->select('assembleia_opcoes.id','opcao')
                    ->get();
                $assembleia['pautas'][$key]['alternativas'] = $opcoes;
            }


            $imoveis = DB::select("
                select 
                    ap.id_imovel, 
                    concat('QD ', i.quadra,' / ', 'LT ', i.lote) as imovel,
                    concat('Peso x ', i.peso_voto) as complemnto,
                    (select count(*) > 0 from assembleia_votacoes av where av.imovel = i.id and id_assembleia  = $assembleia->id ) as voto_realizado,        
                    i.peso_voto
                from assembleia_participantes ap
                inner join bioacesso_portaria.imovel_permanente ip on ap.id_imovel = ip.id_imovel and ip.id_pessoa = $idPessoa
                inner join bioacesso_portaria.imovel i on ip.id_imovel = i.id 
                inner join bioacesso_portaria.tipo_perfil tp on ip.perfil = tp.id 
                where id_assembleia =  $assembleia->id and tp.nome ='associado' and ip.id_pessoa = $idPessoa
            ");

            $assembleia['imoveis'] = $imoveis;

            if ($imoveis && count($imoveis) > 0)
            {
                $assembleia['pode_participar'] = true;
            }
            else
            {
                $assembleia['pode_participar'] = false;
            }

            $assembleia['total_questao_ordem_criadas'] = AssembleiaQuestaoOrdem::join('assembleia_theads', 'assembleia_theads.id',
                'assembleia_questoes_ordens.id_thead')
                ->where('assembleia_theads.id_pessoa', $idPessoa)
                ->where('assembleia_questoes_ordens.id_assembleia', $assembleia->id)
                ->count();

        }
        else
        {
            $assembleia['pautas'] = $assembleia->pautas()
                ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
                ->select('assembleia_pautas.id', 'pergunta', 'assembleia_perguntas.id as id_pergunta' )
                ->get();

            foreach ($assembleia['pautas'] as $key => $pauta)
            {

                $opcoes = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $pauta['id_pergunta'])
                    ->select('assembleia_opcoes.id','opcao')
                    ->get();

                foreach ($opcoes as $opcao)
                {
                    $opcao['total_votos'] = AssembleiaVotacao::where('id_opcao', $opcao['id'])->sum('peso_voto');
                }

                $assembleia['pautas'][$key]['total_votos'] = AssembleiaVotacao::where('id_pergunta', $pauta['id_pergunta'])->sum('peso_voto');
                $assembleia['pautas'][$key]['alternativas'] = $opcoes;
            }
        }


        return $assembleia;
    }

    public function iniciarAssembleia($id)
    {
        try
        {
            $assembleia = Assembleia::find($id);
            $assembleia->status = 'andamento';
            $assembleia->data_inicio = date('Y-m-d');
            $assembleia->hora_inicio = date('H:i:s');
            $assembleia->update();

            return response()->success('Assembleia iniciada!');
        }
        catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }

    }

    public function iniciarVotacao (Request $request)
    {
        $data = $request->all();

        $assembleia = Assembleia::find($data['id_assembleia']);

        if (!$assembleia)
        {
            return response()->error('Assembleia não encontrada!');
        }

        try
        {
            $assembleia->votacao_data_inicio = date('Y-m-d');
            $assembleia->votacao_hora_inicio = date('H:i:s');
            $assembleia->envios_questao_ordem = date('Y-m-d H:i:s');
            $assembleia->envios_encaminhamento = date('Y-m-d H:i:s');
            $assembleia->votacao_data_fim = $data['votacao_data_fim'];
            $assembleia->votacao_hora_fim = $data['votacao_hora_fim'];
            $assembleia->status = 'votacao';

            $assembleia->update();

            return response()->success('Votação iniciada!');

        }
        catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }

    public function encerrarAssembleia($id)
    {
        try
        {
            $assembleia = Assembleia::find($id);
            $assembleia->status = 'encerrada';
            $assembleia->votacao_data_fim = date('Y-m-d');
            $assembleia->votacao_hora_fim = date('H:i:s');
            $assembleia->data_fim = date('Y-m-d');
            $assembleia->hora_fim = date('H:i:s');

            $assembleia->update();

            return response()->success('Assembleia encerrada!');
        }
        catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }

    }
}