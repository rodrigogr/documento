<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummNumeroTableAssembleiaPautas extends Migration
{
    public function up()
    {
        Schema::table('assembleia_pautas', function (Blueprint $table) {
            $table->string('numero')->nullable();
        });
    }

    public function down()
    {

    }
}
