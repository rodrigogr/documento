<?php


namespace App\Http\Controllers\Documento;


use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class DocumentoController extends Controller
{
    public function index()
    {
        $documents = DB::table('documento')->select('nome', 'categoria', 'data_postagem')->get();
        return response()->success($documents);
    }
}