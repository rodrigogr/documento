<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDadosChequesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('dados_cheques')) {
            Schema::create('dados_cheques', function (Blueprint $table) {
                $table->increments('id');

                $table->decimal('valor', 20, 2);
                $table->date('data_emissao');
                $table->date('data_predatado');
                $table->date('data_vencimento');
                $table->string('codigo_banco', 10);
                $table->string('agencia', 20);
                $table->string('conta_bancaria', 20);
                $table->string('numero', 50);

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
        Schema::dropIfExists('dados_cheques');
    }
}
