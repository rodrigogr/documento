<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableDocumentos extends Migration
{
    public function up()
    {
        Schema::create('documentos', function (Blueprint $table)
        {
            $table->increments('id');
            $table->string('nome');
            $table->date('data_envio');
            $table->string('url');
            $table->string('hash_id');
            $table->string('nome_original');
            $table->unsignedInteger('categoria_id');
            $table->foreign('categoria_id')->references('id')->on('documento_categorias');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::drop('documentos');
    }
}
