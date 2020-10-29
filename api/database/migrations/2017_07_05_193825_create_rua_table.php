<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRuaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('ruas')) {
            Schema::create('ruas', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao', 100)->unique();;
                $table->softDeletes();
                $table->timestamps();
            });

            Schema::table('produtos',function($table) {
                $table->unsignedInteger('idrua');
                $table->foreign('idrua')->references('id')->on('ruas')->onDelete('cascade');       
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
        Schema::dropIfExists('ruas');
        Schema::table('produtos',function($table) {
            $table->dropForeign('idrua_foreign');
            $table->dropIndex('idrua_index');
            $table->dropColumn('idrua');     
        });
    }
}
