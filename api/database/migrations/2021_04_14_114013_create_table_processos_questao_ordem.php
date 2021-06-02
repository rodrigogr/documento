<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableProcessosQuestaoOrdem extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('processos_questao_ordem'))
        {
            Schema::create('processos_questao_ordem', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_thead');
                $table->unsignedInteger('id_questao_ordem');
                $table->enum('tipo', ['decisao', 'recurso'])->comment('Define o tipo do processo');
                $table->enum('status', ['deferida', 'indeferida'])->nullable();
                $table->foreign('id_thead')->references('id')->on('assembleia_theads');
                $table->foreign('id_questao_ordem')->references('id')->on('assembleia_questoes_ordens');
                $table->softDeletes();
                $table->timestamps();
            });
        }
    }

    public function down()
    {
        Schema::drop('processos_questao_ordem');
    }
}
