<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterIdBancoParcelaChequesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE parcela_cheques DROP FOREIGN KEY parcela_cheques_id_banco_foreign");
        DB::statement("ALTER TABLE parcela_cheques CHANGE COLUMN id_banco codigo_banco INT(10) UNSIGNED NOT NULL" );
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
