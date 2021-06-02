<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\Models\Assembleia\AssembleiaQuestaoOrdemVotacao;
use App\models\Assembleia\AssembleiaVotacao;

use Illuminate\Http\Request;
use mysql_xdevapi\Exception;

class QuestaoOrdemVotacaoController extends Controller
{
    public function registrarVoto (Request $request)
    {
        $data = $request->all();

        try
        {
            foreach ($data['imoveis'] as $imovel)
            {
                foreach ($data['perguntas'] as $pauta)
                {
                    $assembleiaVotacao = AssembleiaQuestaoOrdemVotacao::
                        where('id_assembleia', $data['id_assembleia'])
                        ->where('id_pergunta', $pauta['id_pergunta'])
                        ->where('imovel', $imovel['id_imovel'])
                        ->get()
                        ->first();

                    usleep(50000);

                    if ($assembleiaVotacao)
                    {
                        if ($assembleiaVotacao->id_pessoa != $data['id_pessoa'])
                        {
                            return response()->error('Seu voto NÃO foi registrado. Outro voto já foi enviado anteriormente por outro associado deste mesmo imóvel.');
                        }

                        return response()->error('Seu voto já foi registrado.');
                    }

                    //\DB::beginTransaction();

                    $voto = AssembleiaQuestaoOrdemVotacao::create([
                        'id_assembleia' => $data['id_assembleia'],
                        'imovel' => $imovel['id_imovel'],
                        'id_pessoa' => $data['id_pessoa'],
                        'id_pergunta' => $pauta['id_pergunta'],
                        'id_opcao' => $pauta['id_alternativa'],
                        'peso_voto' => $imovel['peso_voto']
                    ]);

                    //\DB::commit();

                    //$voto = new AssembleiaVotacao();
                    //$voto->ip = $data['ip'];
                    //$voto->mac_address = $data['mac_address'];
                }
            }

            return response()->success("Votação Realizada");

        } catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }




}