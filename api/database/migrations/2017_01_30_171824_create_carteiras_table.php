<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCarteirasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('carteiras')) {
            Schema::create('carteiras', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao');
                $table->unsignedInteger('id_banco');
                $table->foreign('id_banco')->references('id')->on('bancos');
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
        Schema::dropIfExists('carteiras');
    }
}
