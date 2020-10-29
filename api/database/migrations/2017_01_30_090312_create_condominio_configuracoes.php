<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCondominioConfiguracoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('condominio_configuracoes')) {
            Schema::create('condominio_configuracoes', function (Blueprint $table) {
                $table->increments('id');
                $table->boolean('calculomessubsequente');
                $table->boolean('compensarabatimento');
                $table->integer('diavencimento');
                $table->integer('diaapuracao');
                $table->integer('periododaapuracao');
                $table->enum('tipodeapuracao', ['Despesa Realizada', 'Despesa Estimada']);
                $table->enum('escopoapuracao', ['Realizado', 'Realizado e Provisionado']);
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
        //
    }
}
