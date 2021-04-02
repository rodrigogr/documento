<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaPauta;


class PautaController extends Controller
{
    public function index(int $id)
    {
        return response()->success(AssembleiaPauta::all());
    }
}