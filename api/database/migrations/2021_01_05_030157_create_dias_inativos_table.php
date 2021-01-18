<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDiasInativosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dia_inativo_local_reservavel', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_local_reservavel')->unsigned();
            $table->date('data');
            $table->string('descricao');
            $table->string('repetir', 15);
            $table->foreign('id_local_reservavel')->references('id')->on('local_reservavel')->onDelete('cascade');;
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('dias_inativos');
    }
}
