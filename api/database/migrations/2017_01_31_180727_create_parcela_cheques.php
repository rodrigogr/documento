<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateParcelaCheques extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('parcela_cheques')) {
            Schema::create('parcela_cheques', function (Blueprint $table) {
                $table->unsignedInteger('id_parcela')->primary();
                $table->foreign('id_parcela')->references('id')->on('recebimento_parcelas')->onDelete('cascade');
                $table->date('data_vencimento');
                $table->date('data_emissao');
                $table->date('data_predatado')->nullable();
                $table->unsignedInteger('id_banco');
                $table->foreign('id_banco')->references('id')->on('bancos');
                $table->string('agencia', 7);
                $table->bigInteger('numero_cheque');
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
        Schema::dropIfExists('parcela_cheques');
    }
}
