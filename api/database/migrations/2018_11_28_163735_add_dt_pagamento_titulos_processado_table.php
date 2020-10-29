<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddDtPagamentoTitulosProcessadoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('titulos_processados', function (Blueprint $table) {
            $table->date('dt_pagamento')->nullable()->after('dt_vencimento');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('titulos_processados', function(Blueprint $table)
        {
            $table->dropColumn('dt_pagamento'); //apaga o campo
        });
    }
}
