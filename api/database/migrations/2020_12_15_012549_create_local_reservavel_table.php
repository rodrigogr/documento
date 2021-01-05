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
            $table->smallInteger('capacidade')->nullable()->default(null);
            $table->binary('regras')->nullable()->default(null);;
            $table->integer('id_fotos_local')->nullable()->default(null);
            $table->boolean('visualizar_reversa_usuario')->default(false);
            $table->smallInteger('antecedencia_max_num')->default(0);
            $table->string('antecedencia_max_periodo',10);
            $table->smallInteger('antecedencia_min_num')->default(0);
            $table->string('antecedencia_min_periodo',10);
            $table->smallInteger('antecedencia_cancel_num')->default(0);
            $table->string('antecedencia_cancel_periodo',10);
            $table->smallInteger('limit_reserva')->default(0);
            $table->integer('id_periodo')->nullable()->default(null);
            $table->integer('id_dias_inativos')->nullable()->default(null);
            $table->index('id_fotos_local');
            $table->index('id_periodo');
            $table->index('id_dia_inativo');
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
