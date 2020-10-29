<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnsRecebimentoParcelasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('recebimento_parcelas', function(Blueprint $table)
        {
            $table->double('valor_recebido')->default(0);
            $table->double('valor_multa')->default(0);
            $table->double('valor_juros')->default(0);
            $table->enum('forma_pagamento', ['DINHEIRO', 'CHEQUE', 'TITULO'])->default('TITULO');
            $table->date('data_compensado')->nullable();
            $table->date('data_recebimento')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
