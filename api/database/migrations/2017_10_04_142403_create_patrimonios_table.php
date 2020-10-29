<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePatrimoniosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patrimonios', function (Blueprint $table) {
            $table->increments('id');

            $table->unsignedInteger('id_produto');
            $table->foreign('id_produto')->references('id')->on('produtos');

            $table->string('numero', 255)->nullable();
            $table->string('serie', 255)->nullable();

            $table->text('descricao_garantia')->nullable();
            $table->date('fim_garantia')->nullable();

            $table->string('tipo_lancamento', 255)->nullable();
            $table->string('tipo_incorporacao', 255)->nullable();
            $table->date('data_incorporacao')->nullable();

            $table->date('data_compra')->nullable();
            $table->double('valor', 18, 2)->nullable();

            $table->unsignedInteger('id_empresa')->nullable();
            $table->foreign('id_empresa')->references('id')->on('empresa');

            $table->string('numero_nota_fiscal', 255)->nullable();

            $table->unsignedInteger('id_departamento');
            $table->foreign('id_departamento')->references('id')->on('departamentos');

            $table->text('observacoes')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patrimonios');
    }
}
