<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableDocumentoCategorias extends Migration
{
    public function up()
    {
        Schema::create('documento_categorias', function (Blueprint $table)
        {
            $table->increments('id');
            $table->string('nome');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::drop('documento_categorias');
    }
}
