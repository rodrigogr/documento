<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddValorPercentualPreLancamentoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('pre_lancamentos', function(Blueprint $table)
        {
            if(!Schema::hasColumn('pre_lancamentos', 'valor_percentual')){
                $table->boolean('valor_percentual')->nullable(); //add o campo
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
        Schema::table('pre_lancamentos', function(Blueprint $table)
        {
            $table->dropColumn('valor_percentual'); //apaga o campo
        });
    }
}
