<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumnPrevisaoRetornoPatimoniosManutencoesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('patrimonios_manutencoes', function (Blueprint $table) {
            $table->date('previsao_retorno')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('patrimonios_manutencoes', function (Blueprint $table) {
            $table->date('previsao_retorno')->change();
        });
    }
}
