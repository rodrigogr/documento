<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class RenameColumnEnviosQuestaOrdemTableAssembleias extends Migration
{
    public function up()
    {
        Schema::table('assembleias', function(Blueprint $table) {
            $table->renameColumn('envios_questa_ordem', 'envios_questao_ordem');
        });
    }

    public function down()
    {
        Schema::table('assembleias', function(Blueprint $table) {
            $table->renameColumn('envios_questao_ordem', 'envios_questa_ordem');
        });
    }
}
