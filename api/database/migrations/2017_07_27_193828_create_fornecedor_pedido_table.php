<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFornecedorPedidoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('fornecedor_pedidos')) {
            Schema::create('fornecedor_pedidos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idpedido');
                $table->foreign('idpedido')->references('id')->on('pedidos')->onDelete('cascade');
                $table->unsignedInteger('idfornecedor');
                $table->foreign('idfornecedor')->references('id')->on('empresa')->onDelete('cascade');
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
        Schema::dropIfExists('fornecedor_pedidos');
    }
}