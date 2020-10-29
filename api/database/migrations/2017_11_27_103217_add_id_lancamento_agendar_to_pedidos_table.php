<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIdLancamentoAgendarToPedidosTable extends Migration
{
    public function up(){
        Schema::table('pedidos', function (Blueprint $table) {
            $table->unsignedInteger('id_lancamento_agendar')->nullable();
            $table->foreign('id_lancamento_agendar')->references('id')->on('lancamento_agendar');
        });
    }

    public function down(){
        Schema::table('pedidos', function (Blueprint $table) {
            $table->dropColumn('id_lancamento_agendar');
        });
    }
}