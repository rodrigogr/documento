<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateParcelaPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('parcela_pagar')) {
            Schema::create('parcela_pagar', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_lancamento_agendar');
                $table->foreign('id_lancamento_agendar')->references('id')->on('lancamento_agendar');
                $table->unsignedInteger('id_conta_bancaria');
                $table->foreign('id_conta_bancaria')->references('id')->on('conta_bancarias');
                $table->date('data_base');
                $table->double('valor_pago');
                $table->enum('tipo_operacao', ['Débito', 'Provisão', 'Cancelado']);
                $table->enum('forma_pagamento', ['Dinheiro', 'Depósito', 'Boleto', 'Cheque']);
                $table->date('data_compensacao')->nullable();
                $table->date('data_pagamento');
                $table->double('valor_abatimento')->nullable();
                $table->string('numero_comprovante');
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
        Schema::dropIfExists('parcela_pagar');
    }
}
