<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaDiscussao;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\AssembleiaPost;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use mysql_xdevapi\Exception;

class DiscussaoController extends Controller
{
    public function index($id)
    {
        $assembleiaDicussoes = AssembleiaDiscussao::where('id_assembleia', $id)->group;
        $resul = array();

        foreach ($assembleiaDicussoes as $assembleiaDiscussao)
        {
            $resul = [
                ''
            ];
        }
        return response()->success();
    }

    /*
     * Cria um topico de discussao da assembleia
     *
     * */
    public function createTopico(Request $request)
    {
        $data = $request->all();
        $dataThead = $data['thead'];

        try
        {
            DB::beginTransaction();

            $thead = AssembleiaThead::create($dataThead);

            if (isset($dataThead['anexos']))
            {
                $thead->theadAnexos()->createMany($dataThead['anexos']);
            }

            $assembleiaDiscussao =  AssembleiaDiscussao::create([
                'id_thead'=> $thead->id,
                'id_assembleia'=>$data['id_assembleia'],
                'id_pauta' => $data['id_pauta']
            ]);

            DB::commit();

            return response()->success($assembleiaDiscussao);
        }
        catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }
    }
    /*
     * Cria uma resposta de um topico da assembleia
     *
     * */
    public function replyTopico(Request $request)
    {
        $data = $request->all();
        try {
            DB::beginTransaction();
            $post = AssembleiaPost::create([
                'id_thead'=> $data['id_thead'],
                'id_pessoa'=> $data['id_pessoa'],
                'resposta'=>$data['resposta']
            ]);
            DB::commit();
            return response()->success($post);
        }
        catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }
    }

    public function listTopicosPorPauta($idPauta)
    {
        // falta numero_pauta e total_pauta
        $pautaDiscutida = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
        ->where('assembleia_pautas.id', $idPauta)
        ->select('assembleia_pautas.id as id_pauta','assembleia_perguntas.pergunta')
        ->get()->first();

        // falta os campos like, deslikes e quantidade de comentarios
       $topicos = AssembleiaThead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->join('assembleia_discussoes', 'assembleia_discussoes.id_thead', 'assembleia_theads.id')
            ->where('assembleia_discussoes.id_pauta', $idPauta)
            ->select('assembleia_theads.id','pessoa.nome as autor', 'pessoa.url_foto as foto', 'assembleia_theads.titulo', 'assembleia_theads.created_at', 'assembleia_theads.id_pessoa as likes' )
            ->get();


       foreach ($topicos as $topico)
       {
            $topico['comentarios'] = $topico->posts()->count();
       }

        $pautaDiscutida['topicos'] = $topicos;

        return response()->success($pautaDiscutida);
    }

    public function detalharTopico($idTopico)
    {
        // TODO Get detalhes do topico e comentarios;

        $topico = Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->where('assembleia_theads.id', $idTopico)
            ->select('assembleia_theads.id', 'assembleia_theads.titulo', 'assembleia_theads.texto as descricao',
                'pessoa.nome as autor', 'pessoa.url_foto as foto')
            ->get()
            ->first();

       $topico['comentarios'] = AssembleiaPost::join('bioacesso_portaria.pessoa', 'assembleia_posts.id_pessoa', 'pessoa.id')
            ->where('assembleia_posts.id_thead', $idTopico)->select('assembleia_posts.id as id_comentario',
               'assembleia_posts.resposta', 'pessoa.url_foto as foto', 'pessoa.nome as autor')
           ->get();

        return response()->success($topico);
    }
}