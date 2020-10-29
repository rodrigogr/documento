<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddNossoNumeroOrigemParcelaBoletoTable extends Migration
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
            $table->bigInteger('nosso_numero_origem')->nullable();
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
            $table->dropColumn('nosso_numero_origem');
        });
    }
}
