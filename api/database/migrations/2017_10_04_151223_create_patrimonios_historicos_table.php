<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosHistoricosTable extends Migration
{

    public function up()
    {
        Schema::create('patrimonios_historicos', function (Blueprint $table) {
            $table->increments('id');

            $table->unsignedInteger('id_patrimonio');
            $table->foreign('id_patrimonio')->references('id')->on('patrimonios');

            $table->string('status', 255);

            $table->integer('id_usuario')->nullable();
            $table->foreign('id_usuario')->references('id')->on('usuario');

            $table->dateTime('data_hora')->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('patrimonios_historicos');
    }
}
