<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumsRecebimentoParcelasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('recebimento_parcelas', function (Blueprint $table) {
            $table->double('valor_desconto')->default(0);
            $table->double('valor_abatimento')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('recebimento_parcelas', function (Blueprint $table) {
            $table->dropColumn('valor_desconto');
            $table->dropColumn('valor_abatimento');
        });
    }
}
