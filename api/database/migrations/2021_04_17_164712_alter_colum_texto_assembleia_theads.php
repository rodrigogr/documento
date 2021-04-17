<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumTextoAssembleiaTheads extends Migration
{
   public function up()
    {
        Schema::table('assembleia_theads', function (Blueprint $table)
        {
            $table->longText('texto')->nullable()->change();
        });
    }
    public function down()
    {
        //
    }
}
