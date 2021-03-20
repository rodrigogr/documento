<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\Http\Requests\Assembleia\AssembleiaRequest;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaPergunta;
use League\Flysystem\Exception;

class AssembleiaController extends Controller
{
    public function index()
    {
        return response()->success(Assembleia::all());
    }

    public function store(AssembleiaRequest $request)
    {
        $data = $request->all();

        try
        {
            $assembleia = Assembleia::create($request->all());

            $assembleia->assembleiaDocumentos()->createMany($data['documentos']);

            foreach ($data['pautas'] as $pauta)
            {
                $pergunta = $pauta['pergunta'];
                $opcoes = $pergunta['alternativas'];

                $pergunta = AssembleiaPergunta::create($pergunta);

                $pergunta->assembleiaOpcoes()->createMany($opcoes);

                $assembleia->pautas()->create(['id_pergunta' => $pergunta->id]);
            }

            $assembleia->participantes()->createMany($data['participantes']);

            return response()->success($assembleia);

        } catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }


    }

    public function update()
    {

    }

}