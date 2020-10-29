<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSequenciaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('sequencias')) {
            Schema::create('sequencias', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao', 100)->unique();;
                $table->softDeletes();
                $table->timestamps();
            });

            Schema::table('produtos',function($table) {
                $table->unsignedInteger('idsequencia');
                $table->foreign('idsequencia')->references('id')->on('sequencias')->onDelete('cascade');       
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
        Schema::dropIfExists('sequencias');
        Schema::table('produtos',function($table) {
            $table->dropForeign('idsequencia_foreign');
            $table->dropIndex('idseqencia_index');
            $table->dropColumn('idsequencia');     
        });
    }
}
