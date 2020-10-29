<?php

namespace App\Services;


use App\Models\ContaBancaria;
use App\Models\FluxoCaixa;

class FluxoCaixaServices
{
    static public function createFluxo (array $dados) {
        $v_original = $dados["valor"];
        $s = $dados["fluxo"] === 'DESPESA' ? "-" : "";
        $dados["valor"] = $s.$dados["valor"];
        FluxoCaixa::create($dados);
        $dados["valor"] = $v_original;
        self::saldo($dados);
    }

    static public function updateFluxo (array $dados) {
        $v_original = $dados["valor"];
        $s = $dados["fluxo"] === 'DESPESA' ? "-" : "";
        $dados["valor"] = $s.$dados["valor"];
        FluxoCaixa::where('id_parcela',$dados["id_parcela"])
            ->where('tabela',$dados["tabela"])
            ->update($dados);
        $dados["valor"] = $v_original;
        self::saldo($dados);
    }

    /**
     * @param $dados
     * apenas se tiver data de pagamento ou se for tipo estorno, será alterado o saldo.
     * assim quando for alteração apenas no fluxo, entrará na function saldo mas não sofrerá alteração na conta bancária
     */
    static public function saldo($dados) {
        if (isset($dados["estorno"])) {
            ContaBancaria::where('id',$dados["id_conta_bancaria"])->increment('saldo', $dados["valor"]);
        } elseif (isset($dados["data_pagamento"]) && !is_null($dados["data_pagamento"])) {
            if ($dados["fluxo"] === 'DESPESA') {
                ContaBancaria::where('id',$dados["id_conta_bancaria"])->decrement('saldo', $dados["valor"]);
            } else {
                ContaBancaria::where('id',$dados["id_conta_bancaria"])->increment('saldo', $dados["valor"]);
            }
        }
    }
}