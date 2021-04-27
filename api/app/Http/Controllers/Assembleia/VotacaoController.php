<?php


namespace App\Http\Controllers\Assembleia;


use App\models\Assembleia\AssembleiaVotacao;
use Illuminate\Http\Request;

class VotacaoController
{
    public function votacao (Request $request)
    {
        $data = $request->all();

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

    }

}