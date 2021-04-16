<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPauta;
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

    public function detalhar($idEncaminhamento)
    {
        // TODO Detalhar encaminhamento

        $encaminhamento = DB::table('assembleia_encaminhamentos', 'assembleia_encaminhamentos.id', $idEncaminhamento)
            ->get()->first();

        $pautaDiscutida = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->where('assembleia_pautas.id', $encaminhamento->id_pauta)
            ->select('assembleia_pautas.id as id_pauta','assembleia_perguntas.pergunta')
            ->get()->first();

        $anexos = DB::table('assembleia_theads_anexos')
        ->where('assembleia_theads_anexos.id_thead', $encaminhamento->id_thead)
        ->select('file')
        ->get();

        $pautaDiscutida['encaminhamento'] = Assembleiathead::join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
        ->where('assembleia_theads.id', $encaminhamento->id_thead)
        ->select( 'pessoa.nome as autor', 'pessoa.url_foto as ulr_foto_autor', 'assembleia_theads.titulo')
        ->get();

        $pautaDiscutida['encaminhamento']['anexos'] = $anexos;

        return response()->success($pautaDiscutida);
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