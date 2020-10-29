<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterParcelaPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE parcela_pagar CHANGE COLUMN data_pagamento data_pagamento  DATE NULL");
        DB::statement("ALTER TABLE parcela_pagar CHANGE COLUMN `forma_pagamento` `forma_pagamento` ENUM('Dinheiro','Depósito','Boleto','Cheque','TED', 'DOC') CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL");
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
