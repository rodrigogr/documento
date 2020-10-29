<?php

use Illuminate\Database\Seeder;

class NivelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=NivelSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders NivelSeeder ***";
        $data = [
            ['descricao' => 'GERENCIA'],
            ['descricao' => 'ADMINISTRATIVO'],
            ['descricao' => 'FINANCEIRO']
        ];
        foreach ($data as $dt) {
            \App\Models\Nivel::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
