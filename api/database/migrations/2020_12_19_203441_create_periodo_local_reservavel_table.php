<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePeriodoLocalReservavelTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('periodo_local_reservavel', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_reserva');
            $table->char('dia_semana',3)->nullable(false);
            $table->time('hora_ini');
            $table->time('hora_fim');
            $table->decimal('valor',6,2)->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('periodo_local_reservavel');
    }
}
