<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoTaxasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamento_taxas')) {
            Schema::create('lancamento_taxas', function (Blueprint $table) {
                $table->unsignedInteger('id_lancamento')->primary();
                $table->foreign('id_lancamento')->references('id')->on('lancamentos')->onDelete('cascade');
                $table->unsignedInteger('id_receita_calculos');
                $table->foreign('id_receita_calculos')->references('id')->on('receita_calculos');
                $table->unsignedInteger('id_imovel');
                $table->foreign('id_imovel')->references('id')->on('imovel');
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('receita_calculo_taxas');
    }
}
