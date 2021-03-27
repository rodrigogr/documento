<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\TheadAnexo;
use Illuminate\Http\Request;

class EncaminhamentoController extends Controller
{
    public function index()
    {
        return response()->success(AssembleiaEncaminhamento::all());
    }

    public function store(Request $request)
    {
        $data = $request->all();
        $dataThead = $data['thead'];

        $thead = AssembleiaThead::create($dataThead);
        $thead->theadAnexos()->createMany($dataThead['anexos']);

        $assembleiaEncaminhamento =  AssembleiaEncaminhamento::create([
            'id_thead'=> $thead->id,
            'id_assembleia'=>$data['id_assembleia'],
            'id_pauta' => $data['id_pauta']
        ]);
        return response()->success($assembleiaEncaminhamento);
    }
}