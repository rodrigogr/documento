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
        $documents = Documento::join('documento_categorias', 'documento.categoria_id', 'documento_categorias.id')
        ->select('documento.id', 'documento.nome as documento_nome', 'documento_categorias.nome as categoria_nome', 'data_postagem')->get();
        return response()->success($documents);
    }

    public function store(Request $request)
    {
        $dataset = $request->all();
        try {
            DB::beginTransaction();
            foreach ($dataset as $data)
            {
                $newDocument = Documento::create([
                    'nome' => $data['nome'],
                    'categoria' => $data['categoria']['nome'],
                    'data_postagem' => date('Y-m-d H:i:s'),
                    'url_documento' => $data['url_documento'],
                    'hash_id' => 'js$##%kdfjlkjakjfçkjasl',
                    'nome_original_documento' => $data['nome_original_documento'],
                    'categoria_id' => $data['categoria']['id']
                ]);
            }
            DB::commit();
            return response()->success($newDocument);
        } catch (\Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function show($id)
    {
        $document = Documento::find($id);
        return response()->success($document);
    }

    public function destroy($id)
    {
        Documento::where('id', $id)->delete();
    }

    public function openDocument ($id)
    {
        $document = Documento::find($id);

        $path = public_path('storage/'. $document->name);

        $base64 = explode('base64,', $document->file);

        $contents = base64_decode($base64[1], true);

        \Storage::disk('public')->put($document->name, $contents);

        return response()->download($path)->deleteFileAfterSend(true);
    }
}