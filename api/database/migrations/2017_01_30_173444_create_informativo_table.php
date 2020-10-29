<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateInformativoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('informativo')) {
            Schema::create('informativo', function (Blueprint $table) {
                $table->increments('id');
                $table->enum('tipo', ['Mensagem', 'Imagem']);
                $table->text('conteudo');
                $table->date('datainicial');
                $table->date('datafinal');
                $table->binary('image');
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
        Schema::drop('informativo');
    }
}
