<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProdutosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('produtos')) {
            Schema::create('produtos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idunidade_produto');
                $table->foreign('idunidade_produto')->references('id')->on('unidade_produtos')->onDelete('cascade');
                $table->unsignedInteger('idgrupo_produto');
                $table->foreign('idgrupo_produto')->references('id')->on('grupo_produtos')->onDelete('cascade');
                $table->string('referencia', 50)->unique();
                $table->string('descricao', 100);
                $table->string('quantidade_minima');
                $table->integer('quantidade_maxima');
                $table->enum('origem', ['0XX – NACIONAL', '1XX – ESTRANGEIRA IMPORTAÇÃO DIRETA', '2XX – ESTRANGEIRA ADQUIRIDA NO MERCADO INTERNO']);

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
        Schema::dropIfExists('produtos');
    }
}
