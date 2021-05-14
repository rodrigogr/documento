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
            $table->unsignedInteger('id_imovel')->after('id_pessoa');
            $table->string('ip')->nullable()->after('id_pessoa');
            $table->string('mac_address')->nullable()->after('id_pessoa');
            $table->integer('peso_voto')->nullable()->after('id_pessoa');
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
