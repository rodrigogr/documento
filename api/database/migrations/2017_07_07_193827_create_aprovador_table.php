<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAprovadorTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('aprovadors')) {
            Schema::create('aprovadors', function (Blueprint $table) {
                $table->increments('id');
                $table->integer('idusuario');
                $table->enum('tipo', ['Solicitações', 'Compras', 'Solicitações e compras']);
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
        Schema::dropIfExists('aprovadors');
    }
}