<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumnCategoriaLancamentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('ALTER TABLE lancamentos CHANGE COLUMN categoria categoria TINYINT(4) NOT NULL DEFAULT 1 COMMENT "1=> Taxa, 2=> Fundo, 3=> Juridico, 4=> Custas, 5=> Multa, 6=>Juros, 7=> Descontos, 8=> Outros" ');
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
