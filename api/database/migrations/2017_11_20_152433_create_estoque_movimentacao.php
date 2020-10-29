<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEstoqueMovimentacao extends Migration
{
    public function up()
    {
        Schema::create('estoque_movimentacao', function (Blueprint $table) {
            $table->increments('id');
            $table->string('operacao')->nullable();
            $table->string('observacao')->nullable();
            $table->string('tipo');
            $table->string('numero_nota')->nullable();
            $table->double('valor_nota')->nullable();
            $table->double('valor_itens')->nullable();

            $table->unsignedInteger('id_fornecedor')->nullable();
            $table->foreign('id_fornecedor')->references('id')->on('empresa');

            $table->unsignedInteger('id_pedido')->nullable();
            $table->foreign('id_pedido')->references('id')->on('pedidos');

            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::drop('estoque_movimentacao');
    }
}