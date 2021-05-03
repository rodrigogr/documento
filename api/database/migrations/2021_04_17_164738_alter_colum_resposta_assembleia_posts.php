<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumRespostaAssembleiaPosts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('assembleia_posts', function (Blueprint $table)
        {
            $table->text('resposta')->change();
        });
    }
    public function down()
    {
        //
    }
}
