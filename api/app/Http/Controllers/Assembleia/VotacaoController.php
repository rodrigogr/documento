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

        try
        {
            foreach ($data['imoveis'] as $imovel)
            {
                foreach ($data['pautas'] as $pauta)
                {
                    $voto = AssembleiaVotacao::where('id_pessoa', $data['id_pessoa'])
                        ->where('id_pergunta', $pauta['id_pergunta'])
                        ->where('id_imovel', $imovel['id_imovel'])
                        ->get()
                        ->first();

                    if (!$voto)
                    {
                        $voto = new AssembleiaVotacao();
                        $voto->id_assembleia = $data['id_assembleia'];
                        $voto->id_pessoa = $data['id_pessoa'];
                        $voto->id_pergunta = $pauta['id_pergunta'];
                        //$voto->ip = $data['ip'];
                        $voto->id_imovel = $imovel['id_imovel'];
                        //$voto->mac_address = $data['mac_address'];
                        $voto->peso_voto = $imovel['peso_voto'];
                    }

                    if ($voto->id_pessoa != $data['id_pessoa'])
                    {
                        return response()->error('Voto já registrado!');
                    }

                    $voto->id_opcao = $pauta['id_alternativa'];

                    $voto->id ? $voto->update() : $voto->save();

                }
            }

            return response()->success("Votação Realizada");

        } catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }




}