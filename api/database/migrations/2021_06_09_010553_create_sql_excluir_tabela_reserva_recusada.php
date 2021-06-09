<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSqlExcluirTabelaReservaRecusada extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('INSERT INTO reserva (id_local_reservavel, id_periodo, `data`, id_imovel, id_pessoa, status, created_at, updated_at, deleted_at, obs, autor) 
(select id_local_reservavel, id_periodo, `data`, id_imovel, id_pessoa, status, created_at, updated_at, deleted_at, obs, autor from reserva_recusada)');
        DB::statement('delete from reserva_recusada where id>0');
        DB::statement('DROP TABLE reserva_recusada');
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
