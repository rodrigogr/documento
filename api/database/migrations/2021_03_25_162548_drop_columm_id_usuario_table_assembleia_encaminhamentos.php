<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DropColummIdUsuarioTableAssembleiaEncaminhamentos extends Migration
{
    public function up()
    {
        Schema::table('assembleia_encaminhamentos', function (Blueprint $table) {
            $table->dropColumn('id_usuario');
        });
    }

    public function down()
    {
        //
    }
}
