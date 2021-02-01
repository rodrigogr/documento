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
            $table->integer('id_localidade')->unsigned();
            $table->string('nome');
            $table->text('descricao');
            $table->smallInteger('capacidade')->nullable()->default(null);
            $table->binary('regra_local')->nullable()->default(null);;
            $table->binary('foto_local')->nullable()->default(null);
            $table->boolean('visualizar_reversa_usuario')->default(false);
            $table->smallInteger('antecedencia_max_num')->default(0);
            $table->string('antecedencia_max_periodo',10)->nullable()->default(null);;
            $table->smallInteger('antecedencia_min_num')->default(0);
            $table->string('antecedencia_min_periodo',10)->nullable()->default(null);;
            $table->smallInteger('antecedencia_cancel_num')->default(0);
            $table->string('antecedencia_cancel_periodo',10)->nullable()->default(null);;
            $table->smallInteger('limit_reserva')->default(0);
            $table->timestamps();
            $table->foreign('id_localidade')->references('id')->on('bioacesso_portaria.localidades');
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
