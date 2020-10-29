<?php

use Illuminate\Database\Seeder;

class FormulaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=FormulaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders FormulaSeeder ***";
        $data = [
            ['formula' => 'DESPESA_TOTAL/AREA_TOTAL*AREA_IMOVEL']
        ];
        foreach ($data as $dt) {
            \App\Models\Formula::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
