<?php

use Illuminate\Database\Seeder;

class AprovadorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=AprovadorSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders AprovadorSeeder ***";
        $data = [
            ['descricao' => 'GERENCIA'],
            ['descricao' => 'ADMINISTRATIVO'],
            ['descricao' => 'FINANCEIRO']
        ];
        foreach ($data as $dt) {
            \App\Models\Aprovador::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}