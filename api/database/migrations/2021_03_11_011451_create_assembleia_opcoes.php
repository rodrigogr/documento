<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaOpcoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_opcoes'))
        {
            Schema::create('assembleia_opcoes', function (Blueprint $table)
            {
                $table->increments('id');
                $table->string('opcao');
                $table->unsignedInteger('id_pergunta');
                $table->foreign('id_pergunta')->references('id')->on('assembleia_perguntas');
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
        Schema::drop('assembleia_opcoes');
    }
}
