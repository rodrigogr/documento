<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;


class AlterPedidosTableChangeStatus extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('ALTER TABLE pedidos MODIFY status enum(\'Pendente\', \'Em Aberto\', \'Em cotação\',\'Aprovação da compra\',\'Compra aprovada\',\'Cancelado\',\'Compra Provisionada\',\'Compra Encerrada\');');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement('ALTER TABLE pedidos MODIFY status enum(\'Pendente\', \'Em Aberto\', \'Em cotação\',\'Aprovação da compra\',\'Compra aprovada\',\'Cancelado\');');
    }
}