<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAssembleiaQuestoesOrdensVotacoes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assembleia_questoes_ordens_votacoes', function (Blueprint $table)
        {
            $table->engine = 'MyISAM';
            $table->integer('id')->unsigned();
            $table->unsignedInteger('id_assembleia');
            $table->foreign('id_assembleia')->references('id')->on('assembleias');
            $table->unsignedInteger('imovel');
            $table->unsignedInteger('id_pessoa');
            $table->unsignedInteger('id_pergunta');
            $table->foreign('id_pergunta')->references('id')->on('assembleia_perguntas');
            $table->unsignedInteger('id_opcao');
            $table->foreign('id_opcao')->references('id')->on('assembleia_opcoes');
            $table->integer('peso_voto');
            $table->string('ip')->nullable();
            $table->string('mac_address')->nullable();
            $table->string('id_dispositivo')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->primary(['id','id_assembleia','imovel','id_pergunta'],'assembleia_questoes_ordens_votacoes_primary');
            $table->unique(['id_assembleia', 'imovel','id_pergunta'], 'assembleia_questoes_ordens_unique');

        });

        DB::statement('ALTER TABLE assembleia_questoes_ordens_votacoes MODIFY id INTEGER NOT NULL AUTO_INCREMENT');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('assembleia_questoes_ordens_votacoes');
    }
}
