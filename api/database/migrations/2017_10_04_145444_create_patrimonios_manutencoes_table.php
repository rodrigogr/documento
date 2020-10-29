<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosManutencoesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patrimonios_manutencoes', function (Blueprint $table) {
            $table->increments('id');

            $table->unsignedInteger('id_patrimonio');
            $table->foreign('id_patrimonio')->references('id')->on('patrimonios');

            $table->integer('id_usuario');
            $table->foreign('id_usuario')->references('id')->on('usuario');

            $table->text('motivo');

            $table->unsignedInteger('id_empresa')->nullable();
            $table->foreign('id_empresa')->references('id')->on('empresa');

            $table->date('data_saida');
            $table->date('previsao_retorno');
            $table->date('data_retorno')->nullable();
            $table->double('valor_orcamento', 18, 2)->nullable();
            $table->double('valor_pago', 18, 2)->nullable();
            $table->date('fim_garantia')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patrimonios_manutencoes');
    }
}
