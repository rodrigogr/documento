<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterDescricaoTipoLancamentoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //DB::statement("ALTER TABLE parcela_pagar CHANGE COLUMN numero_comprovante numero_comprovante  VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL");
        DB::statement("ALTER TABLE tipo_lancamentos DROP INDEX tipo_lancamentos_descricao_unique ");
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
