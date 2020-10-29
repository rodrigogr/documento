<?php

use Illuminate\Database\Seeder;

class TipoInadimplenciaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=TipoInadimplenciaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders TipoInadimplenciaSeeder ***";
        $data = [
            ['descricao' => 'Administrativo'],
            ['descricao' => 'Jurídico']
        ];
        foreach ($data as $dt) {
            \App\Models\TipoInadimplencia::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
