<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnCategoriaIdTableDocumento extends Migration
{
    public function up()
    {
        Schema::table('documento', function (Blueprint $table) {
            $table->unsignedInteger('categoria_id')->nullable();
            $table->foreign('categoria_id')->references('id')->on('documento_categorias');

        });
    }

    public function down()
    {
        Schema::table('documento', function (Blueprint $table) {
            $table->dropColumn('categoria_id');
        });
    }
}
