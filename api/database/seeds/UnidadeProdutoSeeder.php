<?php

use Illuminate\Database\Seeder;

class UnidadeProdutoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=UnidadeProdutoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders UnidadeProdutoSeeder ***";
        $data = [
            ['descricao' => 'Kilos'],
            ['descricao' => 'Metros'],
            ['descricao' => 'Unidades'],
            ['descricao' => 'Litros'],
        ];
        foreach ($data as $dt) {
            \App\Models\UnidadeProduto::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
