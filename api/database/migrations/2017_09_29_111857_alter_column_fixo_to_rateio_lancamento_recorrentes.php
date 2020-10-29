<?php

use Illuminate\Database\Migrations\Migration;

class AlterColumnFixoToRateioLancamentoRecorrentes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('ALTER TABLE lancamento_recorrentes CHANGE fixo rateio tinyint(1)');
    }

    /**
     * Reverse the migrations.
     *
     * @return void/
     */
    public function down()
    {
        //
    }
}
