<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnsAssembleiaVotacoes extends Migration
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
            $table->string('plataforma')->nullable();
            $table->dateTime('data_hora_login')->after('id_dispositivo')->nullable();
            $table->string('token')->after('id_dispositivo')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('assembleia_votacoes', function (Blueprint $table)
        {
            $table->dropColumn('token');
            $table->dropColumn('data_hora_login');
            $table->dropColumn('plataforma');
        });
    }
}
