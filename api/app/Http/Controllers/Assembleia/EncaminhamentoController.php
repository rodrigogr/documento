<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\Pauta;
use App\models\Assembleia\TheadAnexo;
use App\Models\Pessoa;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EncaminhamentoController extends Controller
{
    public function index()
    {
        return response()->success(AssembleiaEncaminhamento::all());
    }

    public function store(Request $request)
    {

        try
        {
            DB::beginTransaction();
            $data = $request->all();
            $dataThead = $data['thead'];
            $thead = AssembleiaThead::create($dataThead);
            $thead->theadAnexos()->createMany($dataThead['anexos']);
            $nomeAssociado = DB::connection('portaria')->table('pessoa')->where('id', $dataThead['id_pessoa'])->value('nome');
            $perguntaPauta = DB::table('assembleia_perguntas')->where('id', $data['id_pauta'])->value('pergunta');
            $assembleiaEncaminhamento =  AssembleiaEncaminhamento::create([
                'id_thead'=> $thead->id,
                'id_assembleia'=>$data['id_assembleia'],
                'id_pauta' => $data['id_pauta']
            ]);
            DB::commit();

            $result = [
                'id' => $assembleiaEncaminhamento->id,
                'dataHora'=> $assembleiaEncaminhamento->created_at->format('Y-m-d H:i:s'),
                'status'=> $assembleiaEncaminhamento->status,
                'associado' => $nomeAssociado,
                'pauta' => $perguntaPauta,
                'titulo' => $dataThead['titulo'],
                'apoio' => $assembleiaEncaminhamento->apoio
            ];
            return response()->success($result);
        }
        catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }

    }
}