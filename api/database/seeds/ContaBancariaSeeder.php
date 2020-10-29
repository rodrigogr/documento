<?php

use Illuminate\Database\Seeder;

class ContaBancariaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=ContaBancariaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders ContaBancariaSeeder ***";
        $data = [
            ['idbanco' => 1, 'agencia' => '4319', 'conta' => '28002-2', 'operacao' => '0', 'tipo' => 'CONTA CORRENTE', 'relatorio' => 1, 'saldo' => 0.00]
        ];
        foreach ($data as $dt) {
            \App\Models\ContaBancaria::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
