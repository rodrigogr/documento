<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateContasReceberTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('contas_receber')) {
            Schema::create('contas_receber', function (Blueprint $table) {
                $table->increments('id');
                $table->double('valor_total');
                $table->double('total_abatimento')->nullable()->default(0.00);
                $table->double('total_antecipado')->nullable()->default(0.00);
                $table->double('total_recebido')->nullable()->default(0.00);
                $table->double('total_provisionado')->nullable()->default(0.00);
                $table->double('saldo_receber')->nullable()->default(0.00);
                $table->date('data_agendamento');
                $table->unsignedInteger('id_imovel');
                $table->foreign('id_imovel')->references('id')->on('imovel');
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
        Schema::dropIfExists('contas_receber');
    }
}
