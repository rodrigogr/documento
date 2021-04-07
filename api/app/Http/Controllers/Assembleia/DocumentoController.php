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
}