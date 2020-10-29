<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePreLancamentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('pre_lancamentos')) {
            Schema::create('pre_lancamentos', function (Blueprint $table) {
                $table->unsignedInteger('id_lancamento')->primary();
                $table->foreign('id_lancamento')->references('id')->on('lancamentos')->onDelete('cascade');
                $table->unsignedInteger('idimovel');
                $table->foreign('idimovel')->references('id')->on('imovel')->onDelete('cascade');
                $table->string('observacao', 500)->nullable();
                $table->boolean('cancelamento')->default(0);
                $table->decimal('valor_desconto', 20, 2)->default(0);
                $table->string('descricao_desconto', 200)->nullable();
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
        Schema::dropIfExists('pre_lancamentos');
    }
}
