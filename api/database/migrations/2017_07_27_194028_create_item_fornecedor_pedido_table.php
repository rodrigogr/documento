<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateItemFornecedorPedidoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('item_fornecedor_pedidos')) {
            Schema::create('item_fornecedor_pedidos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idfornecedorpedido');
                $table->foreign('idfornecedorpedido')->references('id')->on('fornecedor_pedidos')->onDelete('cascade');
                $table->unsignedInteger('iditem');
                $table->foreign('iditem')->references('id')->on('item_pedidos')->onDelete('cascade');
                $table->integer('quantidadeFornecedor');  
                $table->float('valorUnitarioFornecedor');     
                $table->float('valorTotal');   
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
        Schema::dropIfExists('item_fornecedor_pedidos');
    }
}