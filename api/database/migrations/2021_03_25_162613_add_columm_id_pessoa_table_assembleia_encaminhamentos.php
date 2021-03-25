<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummIdPessoaTableAssembleiaEncaminhamentos extends Migration
{
    public function up()
    {
        Schema::connection('portal')->table('assembleia_encaminhamentos', function (Blueprint $table) {
            $table->integer('id_pessoa');
        });
    }
    public function down()
    {
        //
    }
}
