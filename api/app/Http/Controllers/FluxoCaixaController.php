<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Models\FluxoCaixa;
use Illuminate\Http\Request;

class FluxoCaixaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function filtroFluxo(Request $request)
    {
        $dados = $request->all();
        $dia_ini = DataHelper::setDate($dados["data_inicio"]);
        $dia_fim = DataHelper::setDate($dados["data_fim"]);

        $filtroFluxo = $this->filtros($dados,$dia_ini,$dia_fim);
        $filtroSaida = $this->filtros($dados,$dia_ini,$dia_fim);
//        return $filtroFluxo->toSql();
        $Data = $filtroFluxo->select('fluxo_caixa.*',
            \DB::raw("CASE WHEN data_pagamento IS NOT NULL then 'REALIZADO' ELSE 'PREVISTO' END AS situacao"));
        $Data = $Data->orderBy('data_vencimento','DESC')
            ->get();

        $entrada = $filtroFluxo->where('fluxo','RECEITA')->sum('valor');
        $saida = $filtroSaida->where('fluxo','DESPESA')->sum('valor');

        $saldoInicial = FluxoCaixa::where('data_pagamento','<',$dia_ini);
        if ($dados["conta"] != "") {
            $saldoInicial = $saldoInicial->where('id',$dados["conta"]);
        }
        $saldoInicial = $saldoInicial->sum('valor');

        return response()->success([
            'entrada' => $entrada,
            'saida' => $saida,
            'fluxo' => $Data,
            'saldo_inicial' => $saldoInicial
        ]);
    }

    public function saldoContas(Request $request)
    {
        $dados = $request->all();
        $dia_ini = DataHelper::setDate($dados["data_inicio"]);
        $dia_fim = DataHelper::setDate($dados["data_fim"]);

        $entrada = FluxoCaixa::where('fluxo','RECEITA')->sum('valor');
        $saida = FluxoCaixa::where('fluxo','DESPESA')->sum('valor');

        return $result = [
            'entrada' => $entrada,
            'saida' => $saida
        ];
    }

    public function filtros($dados, $dia_ini, $dia_fim)
    {
        $Data = FluxoCaixa::with(['contaBancaria' => function ($q) {
            $q->with(['banco' => function ($q) {
                $q->select('id','descricao');
            }]);
            $q->select('id','idbanco','agencia','descricao','conta','saldo');
        }]);
        if ($dados["situacao"] === "TODAS_SITUACOES") {
            $Data = $Data->where( function ($q) use ($dia_ini,$dia_fim) {
                $q->whereNotNull('data_pagamento');
                $q->whereBetween('data_pagamento',[$dia_ini,$dia_fim]);
            });
            $Data = $Data->orWhere( function ($q) use ($dia_ini,$dia_fim) {
                $q->whereNull('data_pagamento');
                $q->whereBetween('data_vencimento',[$dia_ini,$dia_fim]);
            });
        }
        if ($dados["situacao"] === "REALIZADOS") {
            $Data = $Data->whereNotNull('data_pagamento')
                ->whereBetween('data_pagamento',[$dia_ini,$dia_fim]);
        }
        if ($dados["situacao"] === "PREVISTOS") {
            $Data = $Data->whereBetween('data_vencimento',[$dia_ini,$dia_fim])
                ->whereNull('data_pagamento');
        }
        if ($dados["tipo_fluxo"] === 'RECEITA') {
            $Data = $Data->where('fluxo','RECEITA');
        }
        if ($dados["tipo_fluxo"] === 'DESPESA') {
            $Data = $Data->where('fluxo','DESPESA');
        }
        if ($dados["conta"] != "") {
            $Data = $Data->where('id_conta_bancaria',$dados["conta"]);
        }
        return $Data;
    }
}
