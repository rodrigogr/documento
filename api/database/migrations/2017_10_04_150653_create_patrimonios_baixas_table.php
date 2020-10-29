<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosBaixasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patrimonios_baixas', function (Blueprint $table) {
            $table->increments('id');

            $table->unsignedInteger('id_patrimonio');
            $table->foreign('id_patrimonio')->references('id')->on('patrimonios');

            $table->date('data');
            $table->string('tipo', 255);
            $table->string('situacao', 255);
            $table->string('nota_fiscal_saida', 255)->nullable();
            $table->string('destinatario', 255)->nullable();
            $table->text('motivo')->nullable();
            $table->double('valor', 18, 2);
            $table->text('motivo_revogacao')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patrimonios_baixas');
    }
}
