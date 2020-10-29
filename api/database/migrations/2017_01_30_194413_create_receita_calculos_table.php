<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateReceitaCalculosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('receita_calculos')) {
            Schema::create('receita_calculos', function (Blueprint $table) {
                $table->increments('id');
                $table->date('data_calculo');
                $table->date('data_vencimento');
                $table->double('total_despesas_apurada');
                $table->double('area_total_apurada');
                $table->integer('total_imoveis');
                $table->double('fracao_ideal_rateio');
                $table->string('tipo_apuracao');
                $table->double('percentual_juros');
                $table->double('percentual_multa');
                $table->double('percentual_fundo_reserva');
                $table->boolean('termo_aprovacao')->default(0);
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
        Schema::dropIfExists('receita_calculos');
    }
}
