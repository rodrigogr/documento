<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaEncaminhamento;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\AssembleiaPergunta;
use App\models\Assembleia\AssembleiaPost;
use App\models\Assembleia\AssembleiaThead;
use App\models\Assembleia\Pauta;
use App\models\Assembleia\TheadAnexo;
use App\Models\Pessoa;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Exception;

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

            if (isset($dataThead['anexos']))
            {
                $thead->theadAnexos()->createMany($dataThead['anexos']);
            }

            $assembleia = Assembleia::find($request->id_assembleia);

            if ($assembleia->status == 'agendada')
            {
                return response()->error('O envio de encaminhamentos não foi inicicada, pois a assembleia ainda está agendada');
            }

            if($assembleia->status != 'andamento')
            {
                return response()->error('O envio de encaminhamentos foi encerrado manualmente.');
            }

            if(isset($assembleia->envios_encaminhamento))
            {
                throw new Exception('Envios encerrados!');
            }

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

        $encaminhamento = DB::table('assembleia_encaminhamentos', 'assembleia_encaminhamentos.id', $idEncaminhamento)
            ->get()->first();

        $encaminhamento = AssembleiaEncaminhamento::join('assembleia_theads', 'assembleia_theads.id',
            'assembleia_encaminhamentos.id_thead')
            ->join('bioacesso_portaria.pessoa', 'assembleia_theads.id_pessoa', 'pessoa.id')
            ->select('assembleia_encaminhamentos.id', 'assembleia_theads.titulo','assembleia_theads.texto', 'pessoa.url_foto as foto',
                'pessoa.nome as autor', 'assembleia_theads.id as id_thead', 'assembleia_encaminhamentos.id_pauta')
            ->where('assembleia_encaminhamentos.id', $idEncaminhamento)->get()->first();

        $encaminhamento['anexos'] = DB::table('assembleia_theads_anexos')
            ->where('assembleia_theads_anexos.id_thead', $encaminhamento->id_thead)
            ->select('file')
            ->get();

        // Falta os campos numero_pauta | total_pauta
        $encaminhamento['pauta'] = AssembleiaPauta::join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', 'assembleia_perguntas.id')
            ->where('assembleia_pautas.id', $encaminhamento->id_pauta)
            ->select('assembleia_pautas.id as id_pauta','assembleia_perguntas.pergunta')
            ->get()->first();

        $encaminhamento['respostas'] = AssembleiaPost::join('bioacesso_portaria.pessoa', 'assembleia_posts.id_pessoa', 'pessoa.id')
            ->where('id_thead',$encaminhamento->id_thead)
            ->select('resposta','pessoa.url_foto as foto','pessoa.nome as autor')
            ->get();

        return response()->success($encaminhamento);
   }

    /*
     *  Salva uma reposta do encaminhamento
     *
     * */
    public function reply (Request $request)
    {
        $data = $request->all();

        $encaminhamento = AssembleiaEncaminhamento::find($data['id_encaminhamento']);

        DB::beginTransaction();

        $resposta = AssembleiaPost::create([
            'resposta' => $data['resposta'],
            'id_thead' => $encaminhamento->id_thead,
            'id_pessoa' => $data['id_pessoa']
        ]);

        $encaminhamento->status = 'respondido';
        $encaminhamento->update();

        DB::commit();

        return response()->success($resposta);
    }

    public function encerrarEnviosEncaminhamento($id)
    {
        try
        {
            $assembleia = Assembleia::find($id);
            $assembleia->envios_encaminhamento = date('Y-m-d H:i:s');
            $assembleia->update();
            return response()->success('Envios Encerrados!');
        }
        catch (\Exception $e)
        {
            return response()->error('Error :'. $e->getMessage());
        }
    }
}