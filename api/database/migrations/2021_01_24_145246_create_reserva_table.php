<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateReservaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reserva', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_local_reservavel')->unsigned();
            $table->integer('id_periodo')->unsigned();
            $table->date('data');
            $table->integer('id_imovel')->unsigned();
            $table->integer('id_pessoa')->unsigned();
            $table->string('status', 20);
            $table->timestamps();
            $table->softDeletes();
            $table->foreign('id_local_reservavel')->references('id')->on('local_reservavel')->onDelete('cascade');
            $table->foreign('id_periodo')->references('id')->on('periodo_local_reservavel')->onDelete('cascade');
            $table->foreign('id_imovel')->references('id')->on('bioacesso_portaria.imovel')->onDelete('cascade');
            $table->foreign('id_pessoa')->references('id')->on('bioacesso_portaria.pessoa')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('reserva');
    }
}
