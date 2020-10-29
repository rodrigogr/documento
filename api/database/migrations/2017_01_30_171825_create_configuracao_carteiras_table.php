<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateConfiguracaoCarteirasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('configuracao_carteiras')) {
            Schema::create('configuracao_carteiras', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_conta_bancaria');
                $table->foreign('id_conta_bancaria')->references('id')->on('configuracao_carteiras');
                $table->unsignedInteger('id_carteira');
                $table->foreign('id_carteira')->references('id')->on('carteiras');
                $table->unsignedInteger('id_layout_remessa');
                $table->foreign('id_layout_remessa')->references('id')->on('layout_remessas');
                $table->unsignedInteger('id_layout_retorno');
                $table->foreign('id_layout_retorno')->references('id')->on('layout_retornos');
                $table->string('agencia')->nullable();
                $table->string('conta_corrente')->nullable();
                $table->string('codigo_cedente')->nullable();
                $table->string('primeiro_dado_config')->nullable();
                $table->string('segundo_dado_config')->nullable();
                $table->string('instru_cobranca_um')->nullable();
                $table->string('instru_cobranca_dois')->nullable();
                $table->string('instru_cobranca_tres')->nullable();
                $table->string('nosso_numero_inicio')->nullable();
                $table->string('nosso_numero_fim')->nullable();
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
        Schema::dropIfExists('configuracao_carteiras');
    }
}
