<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosApolicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patrimonios_apolices', function (Blueprint $table) {
            $table->increments('id');

            $table->unsignedInteger('id_empresa');
            $table->foreign('id_empresa')->references('id')->on('empresa');

            $table->string('descricao', 255);
            $table->string('numero', 255);

            $table->date('data_inicio');
            $table->date('data_final');

            $table->double('valor_franquia', 18, 2);
            $table->double('valor_premio', 18, 2);

            $table->text('descricao_valores');
            $table->text('motivo_cancelamento')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patrimonios_apolices');
    }
}
