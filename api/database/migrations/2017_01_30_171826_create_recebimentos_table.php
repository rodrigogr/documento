<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRecebimentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
   {
       if (!Schema::hasTable('recebimentos')) {
           Schema::create('recebimentos', function (Blueprint $table) {
               $table->increments('id');
               $table->unsignedInteger('id_configuracao_carteira');
               $table->foreign('id_configuracao_carteira')->references('id')->on('configuracao_carteiras')->onDelete('cascade');
               $table->unsignedInteger('id_layout_remessa');
               $table->foreign('id_layout_remessa')->references('id')->on('layout_remessas')->onDelete('cascade');
               $table->unsignedInteger('idimovel')->nullable();
               $table->foreign('idimovel')->references('id')->on('imovel')->onDelete('cascade');
               $table->unsignedInteger('idassociado')->nullable();
               $table->foreign('idassociado')->references('id')->on('pessoa')->onDelete('cascade');


               $table->enum('forma_pagamento', ['DINHEIRO', 'CHEQUE', 'TITULO'])->nullable();
               $table->date('data_agendamento')->nullable();
               $table->decimal('valor_adicional', 20, 2)->nullable();
               $table->string('descricao_acrescimo', 200)->nullable();
               //cheque/título
               $table->integer('numero_parcelas')->nullable();
               $table->decimal('valor_abatimento', 20, 2)->nullable();
               $table->date('data_recebimento')->nullable();
               $table->string('numero_comprovante', 50)->nullable();

               $table->softDeletes();
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
        Schema::dropIfExists('recebimentos');
    }
}