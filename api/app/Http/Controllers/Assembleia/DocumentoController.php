<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\models\Assembleia\AssembleiaDocumento;

class DocumentoController extends Controller
{
    public function index($id)
    {
        $documentos = AssembleiaDocumento::where('id_assembleia', $id)->get();
        return response()->success($documentos);
    }

    public function destroy($id)
    {
        DB::table('assembleia_documentos')->where('id_assembleia', $id)->delete();
    }

    public function getdocumento ($id)
    {

        $documento = AssembleiaDocumento::find($id);

        return response()->success($documento);
    }

    public function abrirDocumento ($id)
    {
        $documento = AssembleiaDocumento::find($id);

        $path = public_path('storage/'. $documento->name);

        $base64 = explode('base64,', $documento->file);

        $contents = base64_decode($base64[1], true);

        //file_put_contents($path, $contents);
        \Storage::disk('public')->put($documento->name, $contents);

       // var_dump($path); exit();
        return response()->download($path)->deleteFileAfterSend(true);
        //return response()->file('storage/'.$documento->name);
    }
}