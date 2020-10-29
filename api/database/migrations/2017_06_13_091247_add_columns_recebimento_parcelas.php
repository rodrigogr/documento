<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnsRecebimentoParcelas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('recebimento_parcelas', function (Blueprint $table) {
            $table->double('valor_juridico')->default(0)->after('valor_recebido');
            $table->double('valor_custas')->default(0)->after('valor_recebido');;
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
