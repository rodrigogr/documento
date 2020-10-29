<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoAntigoLancamentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lancamento_antigo_lancamentos', function (Blueprint $table) {
            $table->unsignedInteger('id_lancamento_antigo')->index();
            $table->foreign('id_lancamento_antigo')->references('id')->on('lancamento_antigos');
            $table->unsignedInteger('id_lancamento')->index();
            $table->foreign('id_lancamento')->references('id')->on('lancamentos');
            $table->timestamps();
        });
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
