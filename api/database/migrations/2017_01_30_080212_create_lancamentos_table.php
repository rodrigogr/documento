<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamentos')) {
            Schema::create('lancamentos', function (Blueprint $table) {
                $table->increments('id');
                $table->double('valor');
                $table->double('saldo_receber');
                $table->unsignedInteger('idtipo_lancamento')->nullable();
                $table->foreign('idtipo_lancamento')->references('id')->on('tipo_lancamentos')->onDelete('cascade');
                $table->text('descricao');
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
        Schema::dropIfExists('lancamentos');
    }
}
