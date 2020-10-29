<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFluxoCaixaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fluxo_caixa', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('id_conta_bancaria');
            $table->unsignedInteger('id_parcela')->nullable();
            $table->double('valor');
            $table->date('data_vencimento')->nullable();
            $table->date('data_pagamento')->nullable();
            $table->string('descricao', 255)->nullable();
            $table->string('tabela', 50)->nullable();
            $table->enum('fluxo', ['DESPESA', 'RECEITA']);
            $table->softDeletes();
            $table->timestamps();
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
