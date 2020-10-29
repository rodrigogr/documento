<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAcordoParcelasNegociadasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::dropIfExists('acordo_parcelas_negociadas');
        Schema::create('acordo_parcelas_negociadas', function (Blueprint $table) {
            $table->unsignedInteger('id_acordo');
            $table->foreign('id_acordo')->references('id')->on('acordos')->onDelete('cascade');
            $table->unsignedInteger('id_parcela_negociada');
            $table->foreign('id_parcela_negociada')->references('id_parcela')->on('parcela_boletos');
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
