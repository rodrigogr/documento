<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterNumeroComprovanteParcelaPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE parcela_pagar CHANGE COLUMN numero_comprovante numero_comprovante  VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL");
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
