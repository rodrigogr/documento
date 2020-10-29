<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIncluirSomaAcrescimoPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('acrescimo_pagar', function(Blueprint $table)
        {
            if(!Schema::hasColumn('acrescimo_pagar', 'incluir_soma')){
                $table->boolean('incluir_soma')->default(0); //add o campo
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('acrescimo_pagar', function(Blueprint $table)
        {
            $table->dropColumn('incluir_soma'); //apaga o campo
        });
    }
}
