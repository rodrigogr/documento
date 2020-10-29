<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddTipoCobrancaLancamentoAvulsos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('lancamento_avulsos', function(Blueprint $table)
        {
            $table->string('tipo_cobranca',100 )->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('lancamento_avulsos', function(Blueprint $table)
        {
            $table->dropColumn('tipo_cobranca'); //apaga o campo
        });
    }
}
