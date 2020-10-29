<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateReceitasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('receitas')) {
            Schema::create('receitas', function (Blueprint $table) {
                $table->increments('id');
                $table->double('percentualmulta');
                $table->double('percentualjuros');
                $table->enum('modalidadejuro', ['Juros Composto', 'Juros Simples']);
                $table->enum('periodicidadedojuro', ['Ano', 'Mês', 'Dia', 'Semestre', 'Trimestre', 'Quadrimestre']);
                $table->boolean('incidircorrecao');
                $table->enum('indicecorrecao', ['IGMP', 'IGPDI', 'INPC', 'IPCA']);
                $table->boolean('visualizarinstrucao');
                $table->text('instrucaosacado');
                $table->text('localdepagamento');
                $table->boolean('anexarprestacaodecontas');
                $table->integer('mesprestacaodeconta');
                $table->boolean('versoboleto');
                $table->integer('tempoinadimplencia');
                $table->double('valortolerancia');
                //$table->unsignedInteger('id_carteirabancaria');
                $table->unsignedInteger('id_configuracao_carteira');
                $table->unsignedInteger('id_tipolancamentomulta');
                $table->unsignedInteger('id_tipolancamentojuros');
                $table->unsignedInteger('id_tipolancamentocorrecao');
                $table->unsignedInteger('id_tipolancamentocustasadicionais');
                $table->unsignedInteger('id_tipolancamentodesconto');
                $table->unsignedInteger('id_tipoinadimplenciapadrao');
                $table->foreign('id_configuracao_carteira')->references('id')->on('configuracao_carteiras');
                $table->foreign('id_tipolancamentomulta')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipolancamentojuros')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipolancamentocorrecao')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipolancamentocustasadicionais')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipolancamentodesconto')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipoinadimplenciapadrao')->references('id')->on('tipo_inadimplencias');
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
        Schema::dropIfExists('receitas');
    }
}
