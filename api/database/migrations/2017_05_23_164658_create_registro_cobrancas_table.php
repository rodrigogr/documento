<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRegistroCobrancasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('registro_cobrancas', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('id_boleto');
            $table->unsignedInteger('id_empresa')->nullable();
            $table->unsignedInteger('id_imovel')->nullable();
            $table->string('endereco')->nullable();
            $table->string('nome');
            $table->tinyInteger('modelo');
            $table->date('data_vencimento');
            $table->date('data_envio');
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
        Schema::dropIfExists('registro_cobrancas');
    }
}
