<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTitulosProcessadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('titulos_processados')) {
            Schema::create('titulos_processados', function (Blueprint $table) {
                $table->increments('id');
                $table->string('status');
                $table->string('nosso_numero');
                $table->string('numero_documento')->nullable();
                $table->string('numero_controle')->nullable();
                $table->string('ocorrencia')->nullable();
                $table->string('ocorrencia_tipo')->nullable();
                $table->string('desc_ocorrencia')->nullable();
                $table->date('dt_ocorrencia')->nullable();
                $table->date('dt_vencimento')->nullable();
                $table->date('dt_credito')->nullable();
                $table->double('valor')->default(0);
                $table->double('valor_tarifa')->default(0);
                $table->double('valor_iof')->default(0);
                $table->double('valor_abatimento')->default(0);
                $table->double('valor_mora')->default(0);
                $table->double('valor_multa')->default(0);
                $table->double('valor_pago')->default(0);
                $table->double('desconto')->default(0);
                $table->double('juros')->default(0);
                $table->double('multa')->default(0);
                $table->date('dt_pagamento')->nullable();
                $table->date('dt_compenssacao')->nullable();
                $table->double('custos_adicionais')->default(0);
                $table->date('dt_agendamento')->nullable();

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
        Schema::dropIfExists('titulos_processados');
    }
}
