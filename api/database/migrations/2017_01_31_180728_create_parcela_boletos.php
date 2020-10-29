<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateParcelaBoletos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('parcela_boletos')) {
            Schema::create('parcela_boletos', function (Blueprint $table) {
                $table->unsignedInteger('id_parcela')->primary();
                $table->foreign('id_parcela')->references('id')->on('recebimento_parcelas')->onDelete('cascade');
                $table->date('data_vencimento');
                $table->double('percentualmulta');
                $table->double('percentualjuros');
                $table->integer('juros_apos');
                $table->boolean('dias_protesto');
                $table->bigInteger('nosso_numero');
                $table->bigInteger('numero_documento');
                $table->string('situacao');
                $table->boolean('agrupado');
                $table->boolean('aceite');
                $table->string('especie_doc', 2);
                $table->string('file_remessa')->nullable();
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
        Schema::dropIfExists('parcela_boletos');
    }
}
