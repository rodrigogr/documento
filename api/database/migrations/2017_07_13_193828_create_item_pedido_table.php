<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateItemPedidoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('item_pedidos')) {
            Schema::create('item_pedidos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idpedido');
                $table->foreign('idpedido')->references('id')->on('pedidos')->onDelete('cascade');
                $table->unsignedInteger('idproduto');
                $table->foreign('idproduto')->references('id')->on('produtos')->onDelete('cascade');
                $table->enum('tipo_lancamento', ['Produto','Serviço']);
                $table->integer('quantidade');
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
        Schema::dropIfExists('item_pedidos');
    }
}