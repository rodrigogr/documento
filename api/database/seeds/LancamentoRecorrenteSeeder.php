<?php

use Illuminate\Database\Seeder;

class LancamentoRecorrenteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=LancamentoRecorrenteSeeder
//        $start = microtime(true);
//        echo "*** Iniciando os Seeders LancamentoRecorrenteSeeder ***";
//        //Lançamento
//        $data = [
//            ['idtipo_lancamento' => 1, 'valor' => 10000, 'tipo_associacao' => 'LOCALIZAÇÃO', 'idlocalidade' => 1, 'data_expiracao' => '25/05/2017', 'fixo' => 1],
//            ['idtipo_lancamento' => 1, 'valor' => 1200, 'tipo_associacao' => 'IMÓVEIS', 'data_expiracao' => '25/10/2017', 'fixo' => 0],
//            ['idtipo_lancamento' => 1, 'valor' => 150, 'tipo_associacao' => 'IMÓVEIS', 'data_expiracao' => '05/12/2017', 'fixo' => 1],
//            ['idtipo_lancamento' => 1, 'valor' => 652, 'tipo_associacao' => 'PARCEIROS', 'fixo' => 0],
//            ['idtipo_lancamento' => 1, 'valor' => 350, 'tipo_associacao' => 'PARCEIROS', 'fixo' => 1],
//            ['idtipo_lancamento' => 1, 'valor' => 900, 'tipo_associacao' => 'PARCEIROS', 'data_expiracao' => '30/05/2017', 'fixo' => 1],
//        ];
//        foreach ($data as $dt) {
//            \App\Models\LancamentoRecorrente::create($dt);
//        }
//        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
