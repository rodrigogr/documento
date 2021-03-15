<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddModuloMenuAssembleia extends Migration
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
                'nome' => 'assembleia',
                'desc' => 'Assembleia online',
                'tipo_categoria' => 'p'
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

    }
}
