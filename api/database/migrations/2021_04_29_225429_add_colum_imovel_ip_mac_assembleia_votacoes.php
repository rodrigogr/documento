<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumImovelIpMacAssembleiaVotacoes extends Migration
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
            $table->unsignedInteger('id_imovel');
            $table->string('ip')->nullable();
            $table->string('mac_address')->nullable();
            $table->integer('peso_voto')->nullable();
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
