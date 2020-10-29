<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoAgendarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamento_agendar')) {
            Schema::create('lancamento_agendar', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao');
                $table->unsignedInteger('id_tipo_lancamento');
                $table->foreign('id_tipo_lancamento')->references('id')->on('tipo_lancamentos');
                $table->unsignedInteger('id_fornecedor');
                $table->foreign('id_fornecedor')->references('id')->on('empresa');
                $table->integer('mes_competencia');
                $table->integer('ano_competencia');
                $table->date('data_base');
                $table->double('valor');
                $table->bigInteger('numero_nf')->nullable();
                $table->date('data_emissao_nf')->nullable();
                $table->unsignedInteger('id_localizacao');
                $table->foreign('id_localizacao')->references('id')->on('localidades');
                $table->unsignedInteger('id_departamento')->nullable();
                $table->foreign('id_departamento')->references('id')->on('departamentos');
                $table->text('observacao')->nullable();
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
        Schema::dropIfExists('lancamento_agendar');
    }
}
