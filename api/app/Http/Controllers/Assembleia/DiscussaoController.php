<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaDiscussao;
use Illuminate\Http\Request;

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
    public function createTopico (Request $request)
    {
        $data = $request->all();
    }

    /*
     * Cria uma resposta de um topico da assembleia
     *
     * */
    public function replyTopico(Request $request)
    {
        $data = $request->all();
    }
}