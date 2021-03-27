<?php


namespace App\Http\Controllers\Assembleia;

use App\Http\Controllers\Controller;
use App\models\Assembleia\AssembleiaPost;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function store(Request $request){

        return response()->json(AssembleiaPost::create($request->all()),201);
    }
}