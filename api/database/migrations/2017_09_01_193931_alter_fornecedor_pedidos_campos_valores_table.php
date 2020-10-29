<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterFornecedorPedidosCamposValoresTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY valorTotal double(18,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY valorTotalCalculado double(18,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY acrescimo double(18,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY desconto double(18,2);');
        
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY valorTotal double(8,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY valorTotalCalculado double(18,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY acrescimo double(18,2);');
        DB::statement('ALTER TABLE fornecedor_pedidos MODIFY desconto double(18,2);');
        
    }
}
