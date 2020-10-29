<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class UpdateFornecedorPedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('fornecedor_pedidos',function($table) {
            $table->float('valorTotal')-> nullable(true);
            $table->float('valorTotalCalculado')-> nullable(true);  
            $table->float('acrescimo')-> nullable(true);     
            $table->float('desconto')-> nullable(true);     
            $table->string('observacao',100)-> nullable(true);     
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
            $table->float('valorTotal');
            $table->float('valorTotalCalculado');  
            $table->float('acrescimo');     
            $table->float('desconto');     
            $table->string('observacao',100);   
        });
    }
}
