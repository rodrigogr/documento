<?php


namespace App\Http\Controllers\Assembleia;


use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaVotacao;
use Illuminate\Http\Request;
use mysql_xdevapi\Exception;

class VotacaoController
{
    public function registrarVoto (Request $request)
    {
        $data = $request->all();

        try {
            foreach ($data['pautas'] as $pauta)
            {
                $voto = AssembleiaVotacao::where('id_usuario', $data['id_pessoa'])
                    ->where('id_pergunta',$pauta['id_pergunta'])
                    ->get()
                    ->first();

                if(!$voto)
                {
                    $voto = new AssembleiaVotacao();
                    $voto->id_usuario = $data['id_pessoa'];
                    $voto->id_pergunta = $pauta['id_pergunta'];
                }

                $voto->id_opcao = $pauta['id_alternativa'];

                $voto->id ? $voto->update() : $voto->save();

            }

            return response()->success("Votação Realizada");

        } catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }




}