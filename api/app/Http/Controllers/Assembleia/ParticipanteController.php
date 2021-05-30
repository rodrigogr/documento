<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaParticipante;
use App\Models\Pessoa;
use Illuminate\Http\Request;

class ParticipanteController extends Controller
{
    public function index()
    {
        $participantes = \DB::connection('portaria')->table('imovel')
            ->select('id as id_imovel', 'quadra', 'lote', 'peso_voto' )
            ->where('imovel_ficticio',0)->where('softdeleted',0)
            ->get();


        foreach ($participantes as $participante)
        {
            $participante->participar = true;
        }

        return response()->success($participantes);
    }

    public function searchProcurador ($nome)
    {
        $pessoas = \DB::connection('portaria')->table('pessoa')
                    ->select('pessoa.id', 'nome', 'codigo' )
                    ->join('pessoa_permanente', 'pessoa.id', '=', 'pessoa_permanente.id_pessoa')
                    ->where('nome','like', '%'. $nome . '%')
                    ->get();
        return response()->success($pessoas);
    }

    public function salvar(Request $request)
    {
        $data = $request->all();

        try
        {

            $assembleia = Assembleia::find($data['id_assembleia']);

            if (!$assembleia)
            {
                return response()->error('Assembleia não encontrada!');
            }

            if ($assembleia->status != 'agendada' && $assembleia->status != 'andamento' )
            {
                return response()->error('Assembleia em votação ou encerrada!');
            }

            $dataParticipante = $data['participante'];

            if($dataParticipante['participar'])
            {
                $participante = AssembleiaParticipante::create([
                    'id_assembleia' => $data['id_assembleia'],
                    'id_imovel' => $dataParticipante['id_imovel']
                ]);
                $dataParticipante['id_participante'] = $participante->id;
            }
            else
            {
                $participante = AssembleiaParticipante::find($dataParticipante['id_participante']);
                $participante->delete();

                $dataParticipante['id_participante'] = null;
            }
            return response()->success($dataParticipante);

        } catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }

    }
}