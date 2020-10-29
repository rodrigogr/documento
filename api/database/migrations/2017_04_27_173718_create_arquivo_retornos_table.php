<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateArquivoRetornosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('arquivo_retornos')) {
            Schema::create('arquivo_retornos', function (Blueprint $table) {
                $table->increments('id');
                $table->string('nome_arquivo');
                $table->string('caminho_arquivo');
                $table->string('layout');
                $table->date('data_leitura');
                $table->integer('qtd_processado')->default(0);
                $table->integer('qtd_recebida')->default(0);
                $table->integer('qtd_rejeitada')->default(0);
                $table->integer('outras_operacoes')->default(0);
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('arquivo_retornos');
    }
}
