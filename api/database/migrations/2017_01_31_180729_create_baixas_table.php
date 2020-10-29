<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBaixasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('baixas')) {
            Schema::create('baixas', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_parcela');
                $table->foreign('id_parcela')->references('id')->on('recebimento_parcelas')->onDelete('cascade');

                $table->decimal('valor_pago', 20, 2);
                $table->decimal('valor_adicional', 20, 2)->nullable();
                $table->date('data_pagamento');
                $table->date('data_compensacao');
                $table->string('observacao', 200)->nullable();
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
//        Schema::dropIfExists('baixas');
    }
}
