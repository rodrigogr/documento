<?php

use Illuminate\Database\Seeder;

class TipoLancamentoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=TipoLancamentoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders TipoLancamentoSeeder ***";
        $data = [
            ['idgrupo_lancamento' => 1, 'descricao' => 'Taxa Manutenção m2', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Fundo de Reserva', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Multa', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Juros', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Correção', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Custos Adicionais', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Descontos', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Abatimento', 'fluxo' => 'RECEITA'],
            ['idgrupo_lancamento' => 1, 'descricao' => 'Jurídico', 'fluxo' => 'RECEITA']
        ];
        foreach ($data as $dt) {
            \App\Models\TipoLancamento::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
