<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRecebimentoLancamentos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('recebimento_lancamentos')) {
            Schema::create('recebimento_lancamentos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_recebimento');
                $table->unsignedInteger('id_lancamento_receber');
                $table->foreign('id_recebimento')->references('id')->on('recebimentos');
                $table->foreign('id_lancamento_receber')->references('id')->on('lancamentos_contas_receber');
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
        Schema::dropIfExists('recebimento_lancamentos');
    }
}
