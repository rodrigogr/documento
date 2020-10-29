<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAcrescimoPagarTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('acrescimo_pagar')) {
            Schema::create('acrescimo_pagar', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('id_lancamento_agendar');
                $table->foreign('id_lancamento_agendar')->references('id')->on('lancamento_agendar');
                $table->unsignedInteger('id_tipo_lancamento');
                $table->foreign('id_tipo_lancamento')->references('id')->on('tipo_lancamentos');
                $table->double('valor');
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
        Schema::dropIfExists('acrescimo_pagar');
    }
}
