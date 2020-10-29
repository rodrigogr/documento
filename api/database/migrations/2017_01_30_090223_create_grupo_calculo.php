<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateGrupoCalculo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('grupo_calculo')) {
            Schema::create('grupo_calculo', function (Blueprint $table) {
                $table->increments('id');
                $table->string('descricao');
//            $table->text('formula');
                $table->double('percentualfundoreserva');
                $table->unsignedInteger('id_tipolancamento_taxaassociativa');
                $table->unsignedInteger('id_tipolancamento_fundoreserva');
                $table->unsignedInteger('id_formula');
                $table->foreign('id_tipolancamento_taxaassociativa')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_tipolancamento_fundoreserva')->references('id')->on('tipo_lancamentos');
                $table->foreign('id_formula')->references('id')->on('formulas');
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
