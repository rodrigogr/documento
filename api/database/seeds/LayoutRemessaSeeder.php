<?php

use Illuminate\Database\Seeder;

class LayoutRemessaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=LayoutRemessaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders LayoutRemessaSeeder ***";
        $data = [
            ['descricao' => 'CNAB400'],
            ['descricao' => 'CNAB240']
        ];
        foreach ($data as $dt) {
            \App\Models\LayoutRemessa::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***\n";
    }
}
