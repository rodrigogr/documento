<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaVotacoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_votacoes'))
        {
            Schema::create('assembleia_votacoes', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_pergunta');
                $table->unsignedInteger('id_opcao');
                $table->unsignedBigInteger('id_usuario');
                $table->foreign('id_pergunta')->references('id')->on('assembleia_perguntas');
                $table->foreign('id_opcao')->references('id')->on('assembleia_opcoes');
                //$table->foreign('id_usuario')->references('id')->on('usuario');

                $table->softDeletes();
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
        Schema::drop('assembleia_votacoes');
    }
}
