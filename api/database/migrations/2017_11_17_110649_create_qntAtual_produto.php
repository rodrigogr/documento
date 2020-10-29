<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateQntAtualProduto extends Migration
{

    public function up()
    {
        Schema::table('produtos', function (Blueprint $table) {
            $table->integer('quantidade_atual')->nullable();
        });
    }

    public function down()
    {
        Schema::table('produtos', function($table) {
            $table->dropColumn('quantidade_atual')->nullable();
        });
    }
}
