<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoAntigosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lancamento_antigos', function (Blueprint $table) {
            $table->engine = 'InnoDB';

            $table->increments('id');
            $table->unsignedInteger('id_configuracao_carteira')->nullable();
            $table->foreign('id_configuracao_carteira')->references('id')->on('configuracao_carteiras')->onDelete('cascade');
            $table->unsignedInteger('id_layout_remessa')->nullable();
            $table->foreign('id_layout_remessa')->references('id')->on('layout_remessas')->onDelete('cascade');
            $table->unsignedInteger('idimovel')->index();
            $table->date('data_vencimento');
            $table->string('observacao', 500)->nullable();
            $table->boolean('cancelamento')->default(0);
            $table->string('motivo_cancelamento', 500)->nullable();
            $table->unsignedInteger('id_empresa')->nullable()->index();
            $table->string('tipo_cobranca',10);
            $table->softDeletes();
            $table->timestamps();
        });
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
