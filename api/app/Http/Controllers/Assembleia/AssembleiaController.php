<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\Http\Requests\Assembleia\AssembleiaRequest;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaDiscussao;
use App\models\Assembleia\AssembleiaDocumento;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaPost;
use App\models\Assembleia\AssembleiaQuestaoOrdem;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\Pauta;
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
                        $pauta = Pauta::find($item['id']);

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

    public function discussoes ($id)
    {
        // Create Query
        $pautasDiscutidas = AssembleiaDiscussao::
            join('assembleia_pautas', 'assembleia_discussoes.id_pauta', '=', 'assembleia_pautas.id')
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
        // Create Query

        $result = [
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'recurso pendente',
                'associado' => 'Bruno Vinicius Moura da Silva',
                'pauta' => 'Pauta 01',
                'titulo' => 'Titulo Questao Ordem'
            ],
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'recurso pendente',
                'associado' => 'Bruno Vinicius Moura da Silva',
                'pauta' => 'Pauta 01',
                'titulo' => 'Titulo Questao Ordem'
            ],
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'recurso pendente',
                'associado' => 'Bruno Vinicius Moura da Silva',
                'pauta' => 'Pauta 01',
                'titulo' => 'Titulo Questao Ordem'
            ]
        ];

        return response()->success($result);
    }

    public function encaminhamentos ($id)
    {
        // Create Query

        $result =[
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'pendente',
                'asspcoadp' => 'Bruno Vinicius Moura da Silva',
                'pauta' => '01',
                'titulo' => 'Pauta 01',
                'apoio' => 12
            ],
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'pendente',
                'asspcoadp' => 'Bruno Vinicius Moura da Silva',
                'pauta' => '01',
                'titulo' => 'Pauta 01',
                'apoio' => 12
            ],
            [
                'id'=> 1,
                'data_hora' => '2021-03-30 01:41',
                'status' => 'pendente',
                'asspcoadp' => 'Bruno Vinicius Moura da Silva',
                'pauta' => '01',
                'titulo' => 'Pauta 01',
                'apoio' => 12
            ]
        ];

        return response()->success($result);
    }

    public function pautas ($id)
    {
        // Create Query

        $result = [
            [
                'id'=> 1,
                'status' => 'aguardando inicio',
                'pauta' => 'Pauta 01',
                'alternativas' => 4,
                'votos' => 0
            ],
            [
                'id'=> 1,
                'status' => 'aguardando inicio',
                'pauta' => 'Pauta 01',
                'alternativas' => 4,
                'votos' => 0
            ],
            [
                'id'=> 1,
                'status' => 'aguardando inicio',
                'pauta' => 'Pauta 01',
                'alternativas' => 4,
                'votos' => 0
            ]
        ];

        return response()->success($result);
    }

    public function participantes ($id)
    {
        // Create Query

        $result = [
            [
                'id_imovel' => 1,
                'quadra' => '00',
                'lote' => '00',
                'peso' => 0
            ],
            [
                'id_imovel' => 1,
                'quadra' => '00',
                'lote' => '00',
                'peso' => 0
            ],
            [
                'id_imovel' => 1,
                'quadra' => '00',
                'lote' => '00',
                'peso' => 0
            ]
        ];

        return response()->success($result);
    }

}