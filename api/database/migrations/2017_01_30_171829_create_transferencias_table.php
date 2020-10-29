<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransferenciasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('transferencias')) {
            Schema::create('transferencias', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('iddepositante');
                $table->foreign('iddepositante')->references('id')->on('conta_bancarias')->onDelete('cascade');
                $table->unsignedInteger('iddepositario');
                $table->foreign('iddepositario')->references('id')->on('conta_bancarias')->onDelete('cascade');
                $table->date('data');
                $table->decimal('valor', 20, 2);
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
        Schema::dropIfExists('transferencias');
    }
}
