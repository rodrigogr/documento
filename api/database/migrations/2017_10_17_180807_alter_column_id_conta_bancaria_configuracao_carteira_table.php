<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumnIdContaBancariaConfiguracaoCarteiraTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('configuracao_carteiras', function (Blueprint $table) {
            $table->dropForeign('configuracao_carteiras_id_conta_bancaria_foreign');
            $table->foreign('id_conta_bancaria')->references('id')->on('conta_bancarias');
        });
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
