<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddNumeroChequeParcelaPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('parcela_pagar', function(Blueprint $table)
        {
            if(!Schema::hasColumn('parcela_pagar', 'numero_cheque')) {
                $table->integer('numero_cheque')->nullable(); //add o campo
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
        Schema::table('parcela_pagar', function(Blueprint $table)
        {
            $table->dropColumn('numero_cheque'); //apaga o campo
        });
    }
}
