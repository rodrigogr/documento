<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLocalReservavelTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('local_reservavel', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_localidade');
            $table->string('nome');
            $table->text('descricao');
            $table->smallInteger('capacidade');
            $table->integer('regras');
            $table->integer('id_fotos_local');
            $table->boolean('dados_reversa');
            $table->smallInteger('antecedencia_max_num');
            $table->string('antecedencia_max_periodo',10);
            $table->smallInteger('antecedencia_min_num');
            $table->string('antecedencia_min_periodo',10);
            $table->smallInteger('antecedencia_cancel_num');
            $table->string('antecedencia_cancel_periodo',10);
            $table->smallInteger('limit_reserva');
            $table->index('id_fotos_local');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('local_reservavel');
    }
}
