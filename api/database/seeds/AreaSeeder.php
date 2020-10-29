<?php

use Illuminate\Database\Seeder;

class AreaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=AreaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders AreaSeeder ***";
        $data = [
            ['descricao' => 'GERENCIA'],
            ['descricao' => 'ADMINISTRATIVO'],
            ['descricao' => 'FINANCEIRO']
        ];
        foreach ($data as $dt) {
            \App\Models\Area::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
