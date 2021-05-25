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

    public function abirDocumento ($id)
    {
        $documento = AssembleiaDocumento::find($id);

        $path = public_path($documento->name);

        $contents = base64_decode($documento->file);

        file_put_contents($path, $contents);

        return response()->download($path)->deleteFileAfterSend(true);
    }
}