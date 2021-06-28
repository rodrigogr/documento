<?php


namespace App\Http\Controllers\Documento;


use App\Http\Controllers\Controller;
use App\Models\Documentos\Documento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DocumentoController extends Controller
{
    public function index()
    {
        $documents = DB::table('documento')->select('nome', 'categoria', 'data_postagem')->get();
        return response()->success($documents);
    }

    public function store(Request $request)
    {
        $data = $request->all();
        try {
            DB::beginTransaction();
            $newDocument = Documento::create([
                'nome' => $data['nome'],
                'data_postagem' => $data['data_postagem'],
                'url_documento' => $data['url_documento'],
                'nome_original_documento' => $data['nome_original_documento'],
                'categoria_id' => $data['categoria_id']
            ]);
        DB::commit();
        return response()->success($newDocument);
        } catch (\Exception $e) {
            return response()->error($e->getMessage());
        }
    }
}