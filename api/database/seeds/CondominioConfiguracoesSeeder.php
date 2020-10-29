<?php

use Illuminate\Database\Seeder;

class CondominioConfiguracoesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=CondominioConfiguracoesSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders CondominioConfiguracoesSeeder ***";
        $data = [
            ['calculomessubsequente' => 1, 'compensarabatimento'=>1, 'diavencimento'=>20, 'diaapuracao'=>20, 'periododaapuracao'=>31, 'tipodeapuracao'=>'Despesa Estimada', 'escopoapuracao'=>'Realizado']
        ];
        foreach ($data as $dt) {
            \App\Models\CondominioConfiguracoes::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
