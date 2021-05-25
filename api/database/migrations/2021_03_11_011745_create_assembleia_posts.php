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
                $table->longText('resposta');
                $table->unsignedInteger('id_thead');
                $table->foreign('id_thead')->references('id')->on('assembleia_theads');
                $table->unsignedInteger('id_pessoa');
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
