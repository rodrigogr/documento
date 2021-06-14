<?php


namespace App\Http\Controllers\Assembleia;


use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaOpcao;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\Models\Assembleia\AssembleiaQuestaoOrdemPergunta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class QuestaoOrdemPerguntaController
{
    public function index ($idAssembleia)
    {
        $votacoes = AssembleiaQuestaoOrdemPergunta::
            join('assembleia_perguntas', 'assembleia_questoes_ordens_perguntas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->select('assembleia_questoes_ordens_perguntas.id', 'assembleia_perguntas.pergunta','votacao_data_fim','votacao_hora_fim')
            ->where('id_assembleia',$idAssembleia)->get();

        return response()->success($votacoes);
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
    public function listQuestoesOrdensVotacoesPessoa ($idAssembleia, $idPessoa)
    {
        $result = array();

        $votacoes = AssembleiaQuestaoOrdemPergunta::
        join('assembleia_perguntas', 'assembleia_questoes_ordens_perguntas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->select('assembleia_questoes_ordens_perguntas.id_pergunta', 'assembleia_perguntas.pergunta','votacao_data_fim','votacao_hora_fim')
            ->where('id_assembleia',$idAssembleia)->get();


        foreach ($votacoes as $key => $votacao)
        {
            $opcoes = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $votacao['id'])
                ->select('assembleia_opcoes.id','opcao')
                ->get();
            $votacoes[$key]['alternativas'] = $opcoes;
        }

        $result['perguntas'] = $votacoes;

        $imoveis = DB::select("
                select 
                    ap.id_imovel, 
                    concat('QD ', i.quadra,' / ', 'LT ', i.lote) as imovel,
                    concat('Peso x ', i.peso_voto) as complemnto,
                    (select count(*) > 0 from assembleia_questoes_ordens_votacoes aqov where aqov.imovel = i.id and id_assembleia  = $idAssembleia ) as voto_realizado,        
                    i.peso_voto
                from assembleia_participantes ap
                inner join bioacesso_portaria.imovel_permanente ip on ap.id_imovel = ip.id_imovel and ip.id_pessoa = $idPessoa
                inner join bioacesso_portaria.imovel i on ip.id_imovel = i.id 
                inner join bioacesso_portaria.tipo_perfil tp on ip.perfil = tp.id 
                where id_assembleia =  $idAssembleia and tp.nome ='associado' and ip.id_pessoa = $idPessoa
            ");

        $result['imoveis'] = $imoveis;

        if ($imoveis && count($imoveis) > 0)
        {
            $result['pode_participar'] = true;
        }
        else
        {
            $result['pode_participar'] = false;
        }

        return response()->success($result);
    }
}