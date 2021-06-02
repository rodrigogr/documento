<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaQuestoesOrdens extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_questoes_ordens'))
        {
            Schema::create('assembleia_questoes_ordens', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_assembleia');
                $table->foreign('id_assembleia')->references('id')->on('assembleias');
                $table->unsignedInteger('id_pauta');
                $table->foreign('id_pauta')->references('id')->on('assembleia_pautas');
                $table->unsignedInteger('id_thead');
                $table->foreign('id_thead')->references('id')->on('assembleia_theads');
                $table->string('status','100')->default('Pendente de decisão');
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
        Schema::drop('assembleia_questoes_ordens');
    }
}
