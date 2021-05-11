<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumnStatusTableQuestoesOrdens extends Migration
{
    public function up()
    {
        DB::statement("ALTER TABLE assembleia_questoes_ordens MODIFY status ENUM('recurso pendente', 'pendente de decisão', 'deferida', 'recurso indeferido', 'indeferida') NOT NULL");
    }

    public function down()
    {
        DB::statement("ALTER TABLE assembleia_questoes_ordens MODIFY status ENUM('Recurso Pendente', 'Pendente de decisão', 'Deferida', 'Recurso indeferido', 'Indeferida') NOT NULL");
    }
}
