<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummEnviosQuestaoOrdemTableAssembleias extends Migration
{
    public function up()
    {
        Schema::table('assembleias', function (Blueprint $table)
        {
            $table->date('envios_questa_ordem')->nullable();
        });
    }

    public function down()
    {
        //
    }
}
