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
}
