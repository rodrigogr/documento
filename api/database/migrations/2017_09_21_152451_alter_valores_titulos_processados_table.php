<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterValoresTitulosProcessadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('titulos_processados', function(Blueprint $table)
        {
            $table->double('valor_juros_calculado')->default(0);
            $table->double('valor_multa_calculado')->default(0);
            $table->double('valor_total_calculado')->default(0);
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
