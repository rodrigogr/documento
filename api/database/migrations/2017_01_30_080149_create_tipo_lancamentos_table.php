<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTipoLancamentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('tipo_lancamentos')) {
            Schema::create('tipo_lancamentos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idgrupo_lancamento');
                $table->foreign('idgrupo_lancamento')->references('id')->on('grupo_lancamentos')->onDelete('cascade');
                $table->string('descricao', 100)->unique();
                $table->enum('fluxo', ['DESPESA', 'RECEITA']);
                $table->softDeletes();
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
        Schema::drop('tipo_lancamentos');
    }
}
