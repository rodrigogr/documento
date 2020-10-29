<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePedidoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('pedidos')) {
            Schema::create('pedidos', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao');
                $table->timestamp('expectativa_entrega');
                $table->float('expectativa_valor');
                $table->integer('solicitado_id');
                $table->enum('status', ['Pendente', 'Em Aberto', 'Em cotação','Aprovação da compra','Compra aprovada','Cancelado']);
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
        Schema::dropIfExists('pedidos');
    }
}