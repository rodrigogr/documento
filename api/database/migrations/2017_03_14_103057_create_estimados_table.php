<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEstimadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('estimados')) {
            Schema::create('estimados', function (Blueprint $table) {
                $table->increments('id');
                $table->double('valor');
                $table->unsignedInteger('id_tipolancamento');
                $table->unsignedInteger('id_grupolancamento');
                $table->boolean('fundo_reserva')->default(1);
                $table->foreign('id_tipolancamento')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_grupolancamento')->references('id')->on('grupo_lancamentos');
                $table->integer('mes_competencia');
                $table->integer('ano_competencia');
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
        Schema::dropIfExists('estimados');
    }
}
