<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleiaopcao;

class OpcaoController extends Controller
{
    public function destroy($id)
    {
        AssembleiaOpcao::where('id', $id)->delete();
    }
}