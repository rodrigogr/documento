<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAcordosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('acordos')) {
            Schema::create('acordos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_recebimento');
                $table->foreign('id_recebimento')->references('id_recebimento_acordo')->on('recebimento_acordos');
                $table->unsignedInteger('id_associado')->nullable();
                $table->unsignedInteger('id_empresa')->nullable();
                $table->string('nome_parceiro', 100);
                $table->string('forma_pagamento', 100);
                $table->date('data_acordo');
                $table->date('data_agendamento');
                $table->double('valor_divida');
                $table->double('valor_acordo');
                $table->double('multa')->nullable();
                $table->double('juros')->nullable();
                $table->double('correcoes')->nullable();
                $table->double('valor_adicional')->nullable();
                $table->text('descricao_acrescimo')->nullable();
                $table->double('valor_entrada')->nullable();
                $table->date('data_recebimento_entrada')->nullable();
                $table->bigInteger('comprovante_entrada')->nullable();
                $table->tinyInteger('status')->unsigned()->comment('0->cancelado,1->ativo,2->compensado');
                $table->text('cancelamento')->nullable();

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
        Schema::dropIfExists('acordos');
    }
}
