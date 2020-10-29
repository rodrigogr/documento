<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEstoqueMovimentacaoProduto extends Migration
{
    public function up()
    {
        Schema::create('estoque_movimentacao_produto', function (Blueprint $table) {
            $table->increments('id');
            $table->string('estoque_atual')->nullable();
            $table->string('quantidade');
            $table->double('valor_unitario')->nullable();

            $table->unsignedInteger('id_estoque_movimentacao');
            $table->foreign('id_estoque_movimentacao')->references('id')->on('estoque_movimentacao');

            $table->unsignedInteger('id_produto');
            $table->foreign('id_produto')->references('id')->on('produtos');

            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::drop('estoque_movimentacao_produto');
    }
}