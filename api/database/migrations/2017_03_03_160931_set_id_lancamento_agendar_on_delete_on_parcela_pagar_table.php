<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SetIdLancamentoAgendarOnDeleteOnParcelaPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('parcela_pagar', function($table) {
            $table->dropForeign('parcela_pagar_id_lancamento_agendar_foreign');
            $table->foreign('id_lancamento_agendar')->references('id')->on('lancamento_agendar')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('parcela_pagar', function($t) {
            $t->dropForeign('parcela_pagar_id_lancamento_agendar_foreign');
        });
    }
}
