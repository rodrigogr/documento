<?php

use Illuminate\Database\Seeder;

class CarteiraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=CarteiraSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders CarteiraSeeder ***";
        $data = [
            //BRADESCO
            ['descricao' => '09', 'id_banco'=> 1],
            ['descricao' => '21', 'id_banco'=> 1],
            ['descricao' => '26', 'id_banco'=> 1],
            //ITAÚ
            ['descricao' => '109', 'id_banco'=> 2],
            ['descricao' => '110', 'id_banco'=> 2],
            ['descricao' => '111', 'id_banco'=> 2],
            ['descricao' => '112', 'id_banco'=> 2],
            ['descricao' => '115', 'id_banco'=> 2],
            ['descricao' => '121', 'id_banco'=> 2],
            ['descricao' => '180', 'id_banco'=> 2],
            ['descricao' => '188', 'id_banco'=> 2],
            ['descricao' => '180', 'id_banco'=> 2],
            //BANCO do BRASIL
            ['descricao' => '11', 'id_banco'=> 3],
            ['descricao' => '12', 'id_banco'=> 3],
            ['descricao' => '15', 'id_banco'=> 3],
            ['descricao' => '17', 'id_banco'=> 3],
            ['descricao' => '18', 'id_banco'=> 3],
            ['descricao' => '31', 'id_banco'=> 3],
            ['descricao' => '51', 'id_banco'=> 3],
            //SANTANDER
            ['descricao' => '101', 'id_banco'=> 4],
            ['descricao' => '201', 'id_banco'=> 4],
            //CAIXA
            ['descricao' => 'RG', 'id_banco'=> 5],
            //HSBC
            ['descricao' => 'CSB', 'id_banco'=> 6],
            //SICRED
            ['descricao' => '1', 'id_banco'=> 7],
            ['descricao' => '2', 'id_banco'=> 7],
            ['descricao' => '3', 'id_banco'=> 7],
            //BANRISUL
            ['descricao' => '1', 'id_banco'=> 8],
            ['descricao' => '3', 'id_banco'=> 8],
            ['descricao' => '4', 'id_banco'=> 8],
            ['descricao' => '5', 'id_banco'=> 8],
            ['descricao' => '6', 'id_banco'=> 8],
            ['descricao' => '7', 'id_banco'=> 8],
            ['descricao' => '8', 'id_banco'=> 8],
            ['descricao' => 'C', 'id_banco'=> 8],
            ['descricao' => 'D', 'id_banco'=> 8],
            ['descricao' => 'E', 'id_banco'=> 8],
            ['descricao' => 'F', 'id_banco'=> 8],
            ['descricao' => 'H', 'id_banco'=> 8],
            ['descricao' => 'I', 'id_banco'=> 8],
            ['descricao' => 'K', 'id_banco'=> 8],
            ['descricao' => 'M', 'id_banco'=> 8],
            ['descricao' => 'N', 'id_banco'=> 8],
            ['descricao' => 'R', 'id_banco'=> 8],
            ['descricao' => 'S', 'id_banco'=> 8],
            ['descricao' => 'X', 'id_banco'=> 8],
            //SICOOB
            ['descricao' => '1', 'id_banco'=> 9],
            ['descricao' => '3', 'id_banco'=> 9],
            //BNB
            ['descricao' => '21', 'id_banco'=> 10],
            ['descricao' => '31', 'id_banco'=> 10],
            ['descricao' => '41', 'id_banco'=> 10]
        ];
        foreach ($data as $dt) {
            \App\Models\Carteira::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***\n";
    }
}
