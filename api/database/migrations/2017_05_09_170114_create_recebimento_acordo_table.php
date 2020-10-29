<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRecebimentoAcordoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('recebimento_acordos')) {
            Schema::create('recebimento_acordos', function (Blueprint $table) {
                $table->integer('id_recebimento_acordo')->unsigned();
                $table->integer('id_recebimento_antigo')->unsigned();
                $table->softDeletes();
                $table->timestamps();
                $table->index('id_recebimento_acordo');
                $table->index('id_recebimento_antigo');
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
        //
    }
}
