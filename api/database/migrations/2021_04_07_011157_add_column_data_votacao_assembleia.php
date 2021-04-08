<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnDataVotacaoAssembleia extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('assembleias', function (Blueprint $table)
        {
            $table->date('votacao_data_inicio')->nullable();
            $table->time('votacao_hora_inicio')->nullable();
            $table->date('votacao_data_fim')->nullable();
            $table->time('votacao_hora_fim')->nullable();
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
