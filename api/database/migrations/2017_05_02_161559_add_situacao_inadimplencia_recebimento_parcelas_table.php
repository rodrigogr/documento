<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddSituacaoInadimplenciaRecebimentoParcelasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('recebimento_parcelas', function(Blueprint $table)
        {
            $table->unsignedInteger('id_situacao_inadimplencia')->nullable()->after('id_recebimento');
//            $table->foreign('id_situacao_inadimplencia')->references('id')->on('situacao_inadimplencias');
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
