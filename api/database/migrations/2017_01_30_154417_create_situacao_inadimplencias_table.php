<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSituacaoInadimplenciasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('situacao_inadimplencias')) {
            Schema::create('situacao_inadimplencias', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idtipo_inadimplencia');
                $table->foreign('idtipo_inadimplencia')->references('id')->on('tipo_inadimplencias')->onDelete('cascade');
                $table->string('descricao', 100)->unique();
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
        Schema::drop('situacao_inadimplencias');
    }
}
