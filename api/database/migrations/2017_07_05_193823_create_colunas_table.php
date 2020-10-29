<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateColunasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('colunas')) {
            Schema::create('colunas', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao', 100)->unique();;
                $table->softDeletes();
                $table->timestamps();
            });

            Schema::table('produtos',function($table) {
                $table->unsignedInteger('idcolunas');
                $table->foreign('idcolunas')->references('id')->on('colunas')->onDelete('cascade');       
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
        Schema::dropIfExists('colunas');
        Schema::table('produtos',function($table) {
            $table->dropForeign('idcolunas_foreign');
            $table->dropIndex('idcolunas_index');
            $table->dropColumn('idcolunas');     
        });
    }
}
