<?php

use Illuminate\Database\Seeder;

class AreaTotalCondominioSeeder extends Seeder
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
        $areatotal_condominio = \App\Models\Imovel::getAreaTotalCondominio();
        DB::table('condominio')->update(['area_total' => $areatotal_condominio]);
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
