<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaPautasAnexos extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('assembleia_pautas_anexos'))
        {
            Schema::create('assembleia_pautas_anexos', function (Blueprint $table)
            {
                $table->increments('id');
                $table->text('name')->nullable();
                $table->binary('file')->nullable();
                $table->unsignedInteger('id_pauta');
                $table->foreign('id_pauta')->references('id')->on('assembleia_pautas');
                $table->softDeletes();
                $table->timestamps();
            });
        }
    }
    public function down()
    {
        Schema::drop('assembleia_pautas');
    }
}
