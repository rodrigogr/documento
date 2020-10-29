<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumsReceitaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('receitas', function(Blueprint $table)
        {
            $table->unsignedInteger('id_tipolancamentoabatimento')->default(1);
            $table->unsignedInteger('id_tipolancamentojuridico')->default(1);
            $table->foreign('id_tipolancamentoabatimento')->references('id')->on('tipo_lancamentos');
            $table->foreign('id_tipolancamentojuridico')->references('id')->on('tipo_lancamentos');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('receitas', function(Blueprint $table)
        {
            $table->dropColumn('id_tipolancamentoabatimento');
            $table->dropColumn('id_tipolancamentojuridico');

        });
    }
}
