<?php

use Illuminate\Database\Seeder;

class ProdutoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=ProdutoSeeder
//        $start = microtime(true);
//        echo "*** Iniciando os Seeders ProdutoSeeder ***";
//        $data = [
//            ['idunidade_produto' => 1, 'idgrupo_produto' => 1, 'referencia' => '012234564', 'descricao' => 'Lápis', 'quantidade_minima' => 2, 'quantidade_maxima' => 50, 'origem' => '0XX – NACIONAL'],
//            ['idunidade_produto' => 2, 'idgrupo_produto' => 1, 'referencia' => '23542135', 'descricao' => 'Telha', 'quantidade_minima' => 12, 'quantidade_maxima' => 100, 'origem' => '1XX – ESTRANGEIRA IMPORTAÇÃO DIRETA'],
//            ['idunidade_produto' => 1, 'idgrupo_produto' => 2, 'referencia' => '235235235', 'descricao' => 'Martelo', 'quantidade_minima' => 52, 'quantidade_maxima' => 250, 'origem' => '0XX – NACIONAL'],
//            ['idunidade_produto' => 3, 'idgrupo_produto' => 1, 'referencia' => '357548734', 'descricao' => 'Chave', 'quantidade_minima' => 1, 'quantidade_maxima' => 10, 'origem' => '2XX – ESTRANGEIRA ADQUIRIDA NO MERCADO INTERNO'],
//            ['idunidade_produto' => 3, 'idgrupo_produto' => 3, 'referencia' => '2368434', 'descricao' => 'Prego', 'quantidade_minima' => 2, 'quantidade_maxima' => 122, 'origem' => '1XX – ESTRANGEIRA IMPORTAÇÃO DIRETA'],
//            ['idunidade_produto' => 1, 'idgrupo_produto' => 3, 'referencia' => '23524788', 'descricao' => 'Asfalto', 'quantidade_minima' => 5, 'quantidade_maxima' => 200, 'origem' => '2XX – ESTRANGEIRA ADQUIRIDA NO MERCADO INTERNO'],
//        ];
//        foreach ($data as $dt) {
//            \App\Models\Produto::create($dt);
//        }
//        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
