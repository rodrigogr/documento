<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaDiscussoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_dicussoes'))
        {
            Schema::create('assembleia_discussoes', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_assembleia');
                $table->unsignedInteger('id_pauta');
                $table->unsignedInteger('id_thead');
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
        Schema::drop('assembleia_dicussoes');
    }
}
