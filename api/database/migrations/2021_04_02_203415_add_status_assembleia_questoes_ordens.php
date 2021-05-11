<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddStatusAssembleiaQuestoesOrdens extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('assembleia_questoes_ordens', function (Blueprint $table)
        {
            $table->enum('status', ['Pendente de decisão de recurso', 'Pendente de decisão', 'Deferida', 'Recurso indeferido', 'Indeferido', 'Recurso deferido'])->default('Recurso Pendente');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
