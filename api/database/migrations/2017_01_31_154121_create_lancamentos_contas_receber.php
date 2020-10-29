<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentosContasReceber extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamentos_contas_receber')) {
            Schema::create('lancamentos_contas_receber', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_conta_receber');
                $table->unsignedInteger('id_lancamento');
                $table->foreign('id_conta_receber')->references('id')->on('contas_receber');
                $table->foreign('id_lancamento')->references('id')->on('lancamentos');
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
        Schema::dropIfExists('lancamentos_contas_receber');
    }
}
