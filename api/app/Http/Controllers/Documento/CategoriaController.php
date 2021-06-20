<?php


namespace App\Http\Controllers\Documento;


use App\Http\Controllers\Controller;
use App\Models\Documentos\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoriaController extends Controller
{
    public function index()
    {
        $categories = DB::table('documento_categorias')->select('nome')->get();
        return response()->success($categories);
    }

    public function store(Request $request)
    {
        $data = $request->all();
        try {
            DB::beginTransaction();
            $newCategory = Categoria::create(['nome' => $data['nome']]);
            DB::commit();

            return response()->success($newCategory);
        } catch (\Exception $e) {
            return response()->error($e->getMessage());
        }
    }
}