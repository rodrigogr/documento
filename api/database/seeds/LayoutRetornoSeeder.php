<?php

use Illuminate\Database\Seeder;

class LayoutRetornoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=LayoutRetornoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders LayoutRetornoSeeder ***";
        $data = [
            ['descricao' => 'CNAB400'],
            ['descricao' => 'CNAB240']
        ];
        foreach ($data as $dt) {
            \App\Models\LayoutRetorno::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***\n";
    }
}
