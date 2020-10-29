<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterCollunImagemProdutos extends Migration
{
    public function up()
    {
        DB::statement("ALTER TABLE imagem_produtos CHANGE COLUMN imagem imagem MEDIUMBLOB NOT NULL, DROP INDEX imagem_produtos_imagem_unique ;");
    }   

    public function down()
    {
        
    }
}