<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaTheadsAnexos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleia_theads_anexos'))
        {
            Schema::create('assembleia_theads_anexos', function (Blueprint $table)
            {
                $table->increments('id');
                $table->binary('file');
                $table->unsignedInteger('id_assembleia');
                $table->foreign('id_assembleia')->references('id')->on('assembleias');
                $table->softDeletes();
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
