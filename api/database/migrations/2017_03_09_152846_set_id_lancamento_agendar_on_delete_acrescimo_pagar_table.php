<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SetIdLancamentoAgendarOnDeleteAcrescimoPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('acrescimo_pagar', function($table) {
            $table->dropForeign('acrescimo_pagar_id_lancamento_agendar_foreign');
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
        Schema::table('acrescimo_pagar', function($t) {
            $t->dropForeign('acrescimo_pagar_id_lancamento_agendar_foreign');
        });
    }
}
