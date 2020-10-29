<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterTitulosProcessadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('titulos_processados', function(Blueprint $table)
        {
            $table->dropColumn('valor_pago');
            $table->dropColumn('desconto');
            $table->dropColumn('juros');
            $table->dropColumn('multa');
            $table->dropColumn('dt_pagamento');
            $table->dropColumn('dt_compenssacao');
            $table->dropColumn('custos_adicionais');
            $table->dropColumn('dt_agendamento');
            $table->double('valor_desconto')->default(0);
            $table->double('valor_recebido')->default(0);
            $table->boolean('recebimento')->default(0);
            $table->unsignedInteger('id_arquivo_retorno');
            $table->foreign('id_arquivo_retorno')->references('id')->on('arquivo_retornos');
            $table->string('error')->nullable();
            //dt_compenssacao,custos_adicionais,dt_agendamento
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
