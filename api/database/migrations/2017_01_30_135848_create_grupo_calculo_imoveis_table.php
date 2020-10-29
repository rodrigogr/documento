<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateGrupoCalculoImoveisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('grupo_calculo_imoveis')) {
            Schema::create('grupo_calculo_imoveis', function (Blueprint $table) {
                $table->increments('id');
                $table->integer('id_imovel')->unsigned()->unique();
                $table->foreign('id_imovel')->references('id')->on('imovel')->onDelete('cascade');
                $table->integer('id_grupo_calculo')->unsigned();
                $table->foreign('id_grupo_calculo')->references('id')->on('grupo_calculo')->onDelete('cascade');

                $table->timestamps();
            });
        }

        //DB::unprepared('ALTER TABLE `grupo_calculo_imoveis` DROP PRIMARY KEY, ADD PRIMARY KEY (  `id` ,  `id_imovel`, `id_grupo_calculo` )');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('grupo_calculo_imoveis');
    }
}
