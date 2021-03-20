<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaPosts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_posts'))
        {
            Schema::create('assembleia_posts', function (Blueprint $table)
            {
                $table->increments('id');
                $table->string('resposta');
                $table->unsignedInteger('id_thead');
                $table->unsignedInteger('id_usuario');
                //$table->foreign('id_usuario')->references('id')->on('usuario');
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
        Schema::drop('assembleia_posts');
    }
}
