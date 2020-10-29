<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosApolicesPatrimoniosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patrimonios_apolices_patrimonios', function (Blueprint $table) {
            $table->unsignedInteger('id_apolice');
            $table->foreign('id_apolice')->references('id')->on('patrimonios_apolices');

            $table->unsignedInteger('id_patrimonio');
            $table->foreign('id_patrimonio')->references('id')->on('patrimonios');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patrimonios_apolices_patrimonios');
    }
}
