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

    /*
    * Cria um encaminhamento da assembleia
    * */
    public function store(Request $request)
    {
        $data = $request->all();
        $dataThead = $data['thead'];

        try
        {
            DB::beginTransaction();

            $thead = AssembleiaThead::create($dataThead);
            $thead->theadAnexos()->createMany($dataThead['anexos']);

            $assembleiaEncaminhamento =  AssembleiaEncaminhamento::create([
                'id_thead'=> $thead->id,
                'id_assembleia'=>$data['id_assembleia'],
                'id_pauta' => $data['id_pauta']
            ]);

            DB::commit();

            return response()->success($assembleiaEncaminhamento);
        }
        catch (\Exception $e)
        {
            return response()->error($e->getMessage());
        }

    }

    public function detalhar()
    {
        // TODO Detalhar encaminhamento
    }

    /*
     *  Salva uma reposta do encaminhamento
     *
     * */
    public function reply (Request $request)
    {
        $data = $request->all();
    }
}