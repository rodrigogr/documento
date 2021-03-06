<?php

namespace App\Http\Controllers;

use App\Http\Requests\SituacaoImovelRequest;
use App\Models\SituacaoImovel;

class SituacaoImovelController extends Controller
{

    private $name = 'Situação do Imóvel';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Data = SituacaoImovel::all();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.FAE', ['name' => $this->name]));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  SituacaoImovelRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(SituacaoImovelRequest $request)
    {
        try {
            $data = $request->all();
            $Data = SituacaoImovel::create($data);
        } catch (Exception $e) {
            var_dump($e->getMessage());

            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $Data = SituacaoImovel::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  SituacaoImovelRequest $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(SituacaoImovelRequest $request, $id)
    {
        $Data = SituacaoImovel::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
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
        $Data = SituacaoImovel::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.FDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }
}
