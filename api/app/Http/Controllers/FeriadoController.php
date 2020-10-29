<?php

namespace App\Http\Controllers;

use App\Models\Feriado;
use App\Http\Requests\FeriadoRequest;

class FeriadoController extends Controller
{
    private $name = 'Feriado';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = Feriado::all();
        return response()->success($Data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  FeriadoRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(FeriadoRequest $request)
    {
        try {
            $data = $request->all();
            $Data = Feriado::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = Feriado::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  FeriadoRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(FeriadoRequest $request, $id)
    {
        $Data = Feriado::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $Data = Feriado::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }

    }
}
