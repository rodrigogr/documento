<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleias extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('assembleias'))
        {
            Schema::create('assembleias', function (Blueprint $table)
            {
                $table->increments('id');
                $table->string('titulo');
                $table->enum('status', ['Agendada', 'Em andamento', 'Encerrada'])->comment('Define o status da assembleia');
                $table->enum('tipo', ['geral', 'interna'])->comment('Define o tipo de assembleia');
                $table->dateTime('data_hora_inicio');
                $table->dateTime('data_hora_fim')->nullable();
                $table->string('link_transmissao')->nullable();
                $table->boolean('votacao_secreta')->default(false);
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
        //
    }
}
