<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummStatusTableAssembleiaEncaminhamentoss extends Migration
{
    public function up()
    {
        Schema::table('assembleia_encaminhamentos', function (Blueprint $table)
        {
            $table->integer('apoio');
            $table->enum('status', ['respondido', 'pendente'])->default('pendente');
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
