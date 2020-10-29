<?php

use Illuminate\Database\Seeder;

class PreLancamentoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=PreLancamentoSeeder
//        $start = microtime(true);
//        echo "*** Iniciando os Seeders PreLancamentoSeeder ***";
//        $data = [
//            ['idimovel' => 1, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento 1', 'valor' => 10000, 'observacao' => ''],
//            ['idimovel' => 2, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento 1asf', 'valor' => 1500, 'observacao' => 'Teste observação'],
//            ['idimovel' => 3, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento a', 'valor' => 1200, 'observacao' => '', 'valor_desconto' => 105, 'descricao_desconto' => 'Desconto Teste x'],
//            ['idimovel' => 2, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento f1', 'valor' => 10000, 'observacao' => 'Teste'],
//            ['idimovel' => 1, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento 21', 'valor' => 140, 'observacao' => ''],
//            ['idimovel' => 2, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento ff1', 'valor' => 200, 'observacao' => '', 'valor_desconto' => 15, 'descricao_desconto' => 'Desconto Teste'],
//            ['idimovel' => 3, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento 1ass', 'valor' => 30, 'observacao' => ''],
//            ['idimovel' => 3, 'idtipo_lancamento' => 1, 'descricao' => 'Lançamento x1', 'valor' => 100000, 'observacao' => ''],
//        ];
//        foreach ($data as $dt) {
//            $Lanc = \App\Models\PreLancamento::create($dt);
//            \App\Models\Lancamento::create(['idpre_lancamento' => $Lanc->id]);
//        }
//        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
