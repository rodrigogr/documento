<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddFormaPagamentoOrigemParcelaPagar extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('parcela_pagar', function (Blueprint $table) {
            $table->enum('forma_pagamento_origem',['Dinheiro','Depósito','Boleto', 'Cheque'])->default('Boleto')->after('forma_pagamento');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('parcela_pagar', function (Blueprint $table) {
            $table->dropColumn(['forma_pagamento_origem']);
        });
    }
}
