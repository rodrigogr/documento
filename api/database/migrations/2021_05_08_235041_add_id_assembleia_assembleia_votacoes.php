<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIdAssembleiaAssembleiaVotacoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('assembleia_votacoes', function (Blueprint $table)
        {
            $table->unsignedInteger('id_assembleia')->after('id');
            $table->foreign('id_assembleia')->references('id')->on('assembleias');
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
