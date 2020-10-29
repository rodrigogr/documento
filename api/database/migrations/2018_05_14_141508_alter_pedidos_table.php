<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterPedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE pedidos CHANGE COLUMN `status` `status` ENUM('Solicitado', 'Pendente', 'Em Aberto', 'Em cotação', 'Aprovação da compra', 'Compra aprovada', 'Cancelado', 'Compra Provisionada', 'Compra Encerrada') CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
