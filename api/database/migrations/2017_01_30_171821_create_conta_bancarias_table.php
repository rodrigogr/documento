<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateContaBancariasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('conta_bancarias')) {
            Schema::create('conta_bancarias', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idbanco');
                $table->foreign('idbanco')->references('id')->on('bancos')->onDelete('cascade');
                $table->string('agencia', 10);
                $table->string('conta', 10);
                $table->enum('tipo', ['CONTA CORRENTE', 'POUPANÇA', 'CONTA INVESTIMENTO']);
                $table->string('operacao', 10)->nullable();
                $table->boolean('relatorio')->default(0);
                $table->decimal('saldo', 20, 2)->default(0);
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
        Schema::dropIfExists('conta_bancarias');
    }
}
