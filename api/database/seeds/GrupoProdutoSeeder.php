<?php

use Illuminate\Database\Seeder;

class GrupoProdutoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=GrupoProdutoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders GrupoProdutoSeeder ***";
        $data = [
            ['descricao' => 'Escritório'],
            ['descricao' => 'Jardim'],
            ['descricao' => 'Pavimentação'],
            ['descricao' => 'Telhado'],
        ];
        foreach ($data as $dt) {
            \App\Models\GrupoProduto::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
