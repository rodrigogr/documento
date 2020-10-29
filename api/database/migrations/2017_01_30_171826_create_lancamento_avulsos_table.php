<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoAvulsosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamento_avulsos')) {
            Schema::create('lancamento_avulsos', function (Blueprint $table) {
                $table->engine = 'InnoDB';

                $table->unsignedInteger('id_lancamento')->primary();
                $table->foreign('id_lancamento')->references('id')->on('lancamentos')->onDelete('cascade');
                $table->unsignedInteger('id_configuracao_carteira')->nullable();
                $table->foreign('id_configuracao_carteira')->references('id')->on('configuracao_carteiras')->onDelete('cascade');
                $table->unsignedInteger('id_layout_remessa')->nullable();
                $table->foreign('id_layout_remessa')->references('id')->on('layout_remessas')->onDelete('cascade');
                $table->unsignedInteger('idimovel');
                $table->foreign('idimovel')->references('id')->on('imovel')->onDelete('cascade');
                $table->date('data_vencimento');
                $table->string('observacao', 500)->nullable();
                $table->boolean('cancelamento')->default(0);
                $table->string('motivo_cancelamento', 500)->nullable();
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
        Schema::dropIfExists('lancamento_avulsos');
    }
}
