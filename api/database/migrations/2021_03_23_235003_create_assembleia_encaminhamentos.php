<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaEncaminhamentos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_encaminhamentos'))
        {
            Schema::create('assembleia_encaminhamentos', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_assembleia');
                $table->unsignedInteger('id_pauta');
                $table->unsignedInteger('id_thead');
                $table->enum('status', ['Respondido', 'Pendente']);
                $table->integer('apoio');
                $table->foreign('id_assembleia')->references('id')->on('assembleias');
                $table->foreign('id_pauta')->references('id')->on('assembleia_pautas');
                $table->foreign('id_thead')->references('id')->on('assembleia_theads');
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
        Schema::drop('assembleia_encaminhamentos');
    }
}