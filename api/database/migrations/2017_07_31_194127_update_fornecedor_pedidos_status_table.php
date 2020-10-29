<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class UpdateFornecedorPedidosStatusTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('fornecedor_pedidos',function($table) {
            $table->enum('status', ['Não Aprovado','Aprovado']);
        });    
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('fornecedor_pedidos', function($table) {
            $table->enum('status', ['Não Aprovado', 'Aprovado']);
        });
    }
}
