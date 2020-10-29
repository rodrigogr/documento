<?php

use Illuminate\Database\Seeder;

class GrupoCalculoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=GrupoCalculoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders GrupoCalculoSeeder ***";
        $data = [
            ['descricao' => 'Formula Padrão', 'percentualfundoreserva'=>10, 'id_tipolancamento_taxaassociativa'=>1, 'id_tipolancamento_fundoreserva'=>2, 'id_formula'=>1]
        ];
        foreach ($data as $dt) {
            \App\Models\GrupoCalculo::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
