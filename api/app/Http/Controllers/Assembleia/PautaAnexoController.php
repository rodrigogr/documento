<?php


namespace App\Http\Controllers\Assembleia;


use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaPauta;
use App\models\Assembleia\PautaAnexo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PautaAnexoController extends Controller
{
    public function index()
    {
        $pautaAnexos = PautaAnexo::orderBy('id_pauta')->get();

        foreach ($pautaAnexos as $pautaAnexo) {
            $result[] = [
                'id' => $pautaAnexo->id,
                'id_pauta' => $pautaAnexo->id_pauta,
                'name' => $pautaAnexo->name,
                'file' => $pautaAnexo->file
            ];
        }
        return response()->success($result);
    }

    public function store(Request $request)
    {
        $data = $request->all();

        DB::beginTransaction();
        $novoAnexo =  PautaAnexo::create([
            'name'=> $data['name'],
            'file'=> $data['file'],
            'id_pauta'=> $data['id_pauta']
        ]);
        DB::commit();
        return response()->success($novoAnexo);
    }

    public function destroy($id)
    {
        PautaAnexo::where('id', $id)->delete();
    }
}
