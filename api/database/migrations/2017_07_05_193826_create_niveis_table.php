<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateNiveisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('nivels')) {
            Schema::create('nivels', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao', 100)->unique();;
                $table->softDeletes();
                $table->timestamps();
            });

            Schema::table('produtos',function($table) {
                $table->unsignedInteger('idniveis');
                $table->foreign('idniveis')->references('id')->on('nivels')->onDelete('cascade');       
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
        Schema::dropIfExists('nivels');
        Schema::table('produtos',function($table) {
            $table->dropForeign('idniveis_foreign');
            $table->dropIndex('idniveis_index');
            $table->dropColumn('idniveis');     
        });
    }
}
