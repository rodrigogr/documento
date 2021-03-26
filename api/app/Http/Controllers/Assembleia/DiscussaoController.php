<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaDiscussao;

class DiscussaoController extends Controller
{
    public function index(int $id)
    {
        return response()->success(AssembleiaDiscussao::all());
    }
}