<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddModulosMenuComunicacao extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //\DB::connection('portaria')->raw('(CASE WHEN conta_bancarias.id = receitas.id_configuracao_carteira THEN 1 ELSE 0 END) AS padrao'), 'bancos.descricao as banco')
        // Insert some stuff
        DB::connection('portaria')->table('modulo_sistema')->insert(
            array([
                'nome' => 'reserva',
                'desc' => 'Reservas',
                'tipo_categoria' => 'p'
            ],[
                'nome' => 'reservaLocal',
                'desc' => 'Locais Reserváveis',
                'tipo_categoria' => 's'
            ],[
                'nome' => 'reservaCalendario',
                'desc' => 'Calendário de Reservas',
                'tipo_categoria' => 's'
            ],[
                'nome' => 'reservaAprovacao',
                'desc' => 'Aprovações Pendentes',
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
