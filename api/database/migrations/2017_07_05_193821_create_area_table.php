<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAreaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('areas')) {
            Schema::create('areas', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao', 100)->unique();;
                $table->softDeletes();
                $table->timestamps();
            });
            Schema::table('produtos',function($table) {
                $table->unsignedInteger('idarea');
                $table->foreign('idarea')->references('id')->on('areas')->onDelete('cascade');       
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
        Schema::dropIfExists('areas');
        Schema::table('produtos',function($table) {
            $table->dropForeign('idarea_foreign');
            $table->dropIndex('idarea_index');
            $table->dropColumn('idarea');     
        });
    }
}
