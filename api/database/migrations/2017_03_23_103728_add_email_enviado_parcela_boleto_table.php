<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddEmailEnviadoParcelaBoletoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('parcela_boletos', function(Blueprint $table)
        {
            $table->boolean('email_enviado')->default(0); //add o campo
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('parcela_boletos', function(Blueprint $table)
        {
            $table->dropColumn('email_enviado'); //apaga o campo
        });
    }
}
