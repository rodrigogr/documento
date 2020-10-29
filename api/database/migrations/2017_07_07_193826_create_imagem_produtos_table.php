<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
class CreateImagemProdutosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('imagem_produtos')) {
            Schema::create('imagem_produtos', function (Blueprint $table) {
                $table->increments('id');
                $table->unsignedInteger('idprodutos');
                $table->foreign('idprodutos')->references('id')->on('produtos')->onDelete('cascade');       
                $table->string('imagem', 100)->unique();;
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
        Schema::dropIfExists('imagem_produtos');
    }
}
