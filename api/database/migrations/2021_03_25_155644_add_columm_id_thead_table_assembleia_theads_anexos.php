<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummIdTheadTableAssembleiaTheadsAnexos extends Migration
{
    public function up()
    {
        Schema::table('assembleia_theads_anexos', function (Blueprint $table) {
            $table->integer('id_thead');
        });
    }
    public function down()
    {
        //
    }
}
