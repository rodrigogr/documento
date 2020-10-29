<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterNumeroNfLancamentoAgendarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('lancamento_agendar', function (Blueprint $table) {
            $table->string('numero_nf', 255)->change();
        });
       // DB::statement("ALTER TABLE 'lancamento_agendar' CHANGE COLUMN 'numero_nf' 'numero_nf' VARCHAR(255) NULL DEFAULT NULL");
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
