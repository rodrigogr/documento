<?php

use Illuminate\Database\Seeder;

class GrupoCalculoImovelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $start = microtime(true);
        echo "*** Iniciando os Seeders GrupoCalculoImoveisSeeder ***";
        $result = \App\Models\Imovel::all('id');

        foreach ($result as $item) {
            $data = [
                'id_imovel'=> $item->id,
                'id_grupo_calculo'=>1
            ];

            \App\Models\GrupoCalculoImovel::create($data);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
