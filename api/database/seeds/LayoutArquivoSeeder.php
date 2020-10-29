<?php

use Illuminate\Database\Seeder;

class LayoutArquivoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=LayoutArquivoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders LayoutArquivoSeeder ***";
        $data = [
            ['descricao' => 'Descrição 1', 'arquivo' => 'asbdjkabskjdbaskjfbvasf'],
            ['descricao' => 'Descrição 2', 'arquivo' => 'asbdjkabskjdbaskjfbvasf'],
        ];
        foreach ($data as $dt) {
            \App\Models\LayoutArquivo::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
    //

}
