<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DropTableDocumento extends Migration
{
    public function up()
    {
        Schema::drop('documento');
    }

    public function down()
    {
        //
    }
}
