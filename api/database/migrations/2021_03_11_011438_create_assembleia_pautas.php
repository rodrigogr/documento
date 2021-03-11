<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaPautas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_pautas'))
        {
            Schema::create('assembleia_pautas', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_assembleia');
                $table->unsignedInteger('id_pergunta');
                $table->foreign('id_assembleia')->references('id')->on('assembleias');
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
        //
    }
}
