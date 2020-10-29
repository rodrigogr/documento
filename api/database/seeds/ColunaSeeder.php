<?php

use Illuminate\Database\Seeder;

class ColunaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=ColunaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders ColunaSeeder ***";
        $data = [
            ['descricao' => 'GERENCIA'],
            ['descricao' => 'ADMINISTRATIVO'],
            ['descricao' => 'FINANCEIRO']
        ];
        foreach ($data as $dt) {
            \App\Models\Coluna::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
