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
            $table->renameColumn('id_usuario', 'id_pessoa');
            $table->unsignedInteger('id_imovel')->after('id_usuario');
            $table->string('ip')->nullable()->after('id_usuario');
            $table->string('mac_address')->nullable()->after('id_usuario');
            $table->integer('peso_voto')->nullable()->after('id_usuario');
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
