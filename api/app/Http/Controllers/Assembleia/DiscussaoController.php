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
        // TODO Get todos os topicos dicutido pela pauta;
    }

    public function detalharTopico($idTopico)
    {
        // TODO Get detalhes do topico e comentarios;
    }
}