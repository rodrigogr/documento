<?php

use Illuminate\Database\Seeder;

class SequenciaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=SequenciaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders SequenciaSeeder ***";
        $data = [
            ['descricao' => 'GERENCIA'],
            ['descricao' => 'ADMINISTRATIVO'],
            ['descricao' => 'FINANCEIRO']
        ];
        foreach ($data as $dt) {
            \App\Models\Sequencia::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
