<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaDiscussao;
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
            $thead->theadAnexos()->createMany($dataThead['anexos']);

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
                'id_usuario'=> $data['id_usuario'],
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
        $topicosDaPautaDiscutida = AssembleiaDiscussao::join('assembleia_theads', 'assembleia_discussoes.id_thead', 'assembleia_theads.id')
            ->join('assembleia_pautas', 'assembleia_discussoes.id_pauta', 'assembleia_pautas.id')
            ->where('assembleia_discussoes.id_pauta', $idPauta)->get();

        $topicos = array();

        foreach ($topicosDaPautaDiscutida as $topico)
        {
            $topicos[] =
                [
                    "autor" => $topico->id_pessoa,
                    "ulr_foto_autor" => "",
                    "titulo" => $topico->texto,
                    "like" => 10,
                    "deslike" => 2,
                    "comentarios" => 5
                ];
        }

        $result[] = [
            'id_pauta' => $idPauta,
            'numero_pauta' => 1,
            'total_pauta' => 2,
            'título' => "Pauta 01",
            'topicos' => $topicos
        ];

        return response()->success($result);
    }

    public function detalharTopico($idTopico)
    {
        // TODO Get detalhes do topico e comentarios;

        $topico = Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->where('assembleia_theads.id', $idTopico)
            ->select('assembleia_theads.id as id_topico', 'assembleia_theads.titulo', 'assembleia_theads.texto as descricao',
                'pessoa.nome as autor', 'pessoa.url_foto as ulr_foto_autor')
            ->get()
            ->first();

       $topico['comentarios'] = AssembleiaPost::join('bioacesso_portaria.pessoa', 'assembleia_posts.id_usuario', 'pessoa.id')
            ->where('assembleia_posts.id_thead', $idTopico)->select('assembleia_posts.id as id_comentario',
               'assembleia_posts.resposta as comentario', 'pessoa.url_foto as ulr_foto_autor', 'pessoa.nome as autor')
           ->get();

        return response()->success($topico);
    }
}