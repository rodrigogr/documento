<?php

use Illuminate\Database\Seeder;
use App\Models\Localidade;

class LocalidadeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=LocalidadeSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders LocalidadeSeeder ***";
        Localidade::create(array('descricao' => 'Condomínio'));
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
