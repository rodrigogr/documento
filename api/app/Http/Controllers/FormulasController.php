<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Formula;

class FormulasController extends Controller
{
    public function index()
    {
        return response()->success(Formula::all());
    }

    public function store(Request $request)
    {
        //
    }

    public function show($id)
    {
        //
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        //
    }
}