<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaTheads extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_theads'))
        {
            Schema::create('assembleia_theads', function (Blueprint $table)
            {
                $table->increments('id');
                $table->string('titulo');
                $table->string('texto');
                $table->unsignedInteger('id_usuario');
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
        Schema::drop('assembleia_theads');
    }
}
