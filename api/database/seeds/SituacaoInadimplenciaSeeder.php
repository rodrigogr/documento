<?php

use Illuminate\Database\Seeder;

class SituacaoInadimplenciaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=SituacaoInadimplenciaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders SituacaoInadimplenciaSeeder ***";
        $data = [
            ['idtipo_inadimplencia' => 1, 'descricao' => 'INTERNA']
        ];
        foreach ($data as $dt) {
            \App\Models\SituacaoInadimplencia::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
