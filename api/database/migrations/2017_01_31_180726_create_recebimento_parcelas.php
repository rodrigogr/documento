<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRecebimentoParcelas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('recebimento_parcelas')) {
            Schema::create('recebimento_parcelas', function (Blueprint $table) {
                $table->increments('id');
                $table->double('valor');
                $table->unsignedInteger('id_recebimento');
                $table->foreign('id_recebimento')->references('id')->on('recebimentos');
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
        Schema::dropIfExists('recebimento_parcela');
    }
}
