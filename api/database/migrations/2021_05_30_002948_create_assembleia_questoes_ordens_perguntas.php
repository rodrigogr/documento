<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaQuestoesOrdensPerguntas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assembleia_questoes_ordens_perguntas', function (Blueprint $table)
        {
            $table->increments('id');
            $table->unsignedInteger('id_assembleia');
            $table->foreign('id_assembleia')->references('id')->on('assembleias');
            $table->unsignedInteger('id_pergunta');
            $table->foreign('id_pergunta')->references('id')->on('assembleia_perguntas');
            $table->date('votacao_data_fim');
            $table->time('votacao_hora_fim');
            $table->text('motivo')->nullable();
            $table->dateTime('encerramento_votacao')->nullable();
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
        Schema::drop('assembleia_questoes_ordens_perguntas');
    }
}
