<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaParticipantes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_participantes'))
        {
            Schema::create('assembleia_participantes', function (Blueprint $table)
            {
                $table->increments('id');
                $table->unsignedInteger('id_assembleia');
                $table->unsignedInteger('id_imovel');
                $table->unsignedInteger('id_procurador');
                $table->foreign('id_assembleia')->references('id')->on('assembleias');
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
        Schema::drop('assembleia_participantes');
    }
}
