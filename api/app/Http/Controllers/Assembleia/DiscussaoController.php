<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaDiscussao;

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
}