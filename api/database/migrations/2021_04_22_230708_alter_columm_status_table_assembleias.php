<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColummStatusTableAssembleias extends Migration
{
    public function up()
    {
        DB::statement("ALTER TABLE assembleias MODIFY COLUMN status enum('agendada','andamento','encerrada', 'votacao') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Define o status da assembleia';");
    }

    public function down()
    {
        //
    }
}
