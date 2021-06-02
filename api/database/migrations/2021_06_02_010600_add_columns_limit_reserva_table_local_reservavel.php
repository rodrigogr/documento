<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnsLimitReservaTableLocalReservavel extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('local_reservavel', function (Blueprint $table)
        {
            $table->smallInteger('limit_reserva_unidade')->default(0)->after('antecedencia_cancel_periodo');
            $table->smallInteger('limit_reserva_periodo')->default(0)->after('antecedencia_cancel_periodo');
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
