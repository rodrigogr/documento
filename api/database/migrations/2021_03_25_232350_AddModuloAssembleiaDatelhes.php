<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddModuloAssembleiaDatelhes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::connection('portaria')->table('modulo_sistema')->insert(
            array([
                'nome' => 'assembleiaDetalhes',
                'desc' => 'Assembleia Detalhes',
                'tipo_categoria' => 's'
            ])
        );
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
