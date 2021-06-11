<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\PautaAnexo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PautaAnexoController extends Controller
{
    public function index($id)
    {
        $pautaAnexos = PautaAnexo::where('id_pauta', $id)->get();
        return response()->success($pautaAnexos);
    }

    public function destroy($id)
    {
        PautaAnexo::where('id', $id)->delete();
    }

    public function show($id)
    {
        $anexo = PautaAnexo::find($id);
        return response()->success($anexo);
    }

    public function abrirDocumento ($id)
    {
        $documento = PautaAnexo::find($id);

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
