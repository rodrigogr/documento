<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateColummStatusTableAssembleias extends Migration
{
    public function up()
    {
        Schema::table('assembleias', function (Blueprint $table)
        {
            $table->enum('status', ['encerrada', 'agendada', 'andamento','votacao'])->default('andamento');
        });
    }
    public function down()
    {
        //
    }
}
