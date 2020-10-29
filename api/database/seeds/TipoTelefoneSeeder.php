<?php

use Illuminate\Database\Seeder;
use App\Models\TipoTelefone;

class TipoTelefoneSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
//        //php artisan db:seed --class=TipoTelefoneSeeder
//        $start = microtime(true);
//        echo "*** Iniciando os Seeders TipoTelefoneSeeder ***";
//    /*    TipoTelefone::create(array('descricao' => 'Telefone Fixo'));
//        TipoTelefone::create(array('descricao' => 'Celular'));
//        TipoTelefone::create(array('descricao' => 'Telefone Fixo do Trabalho'));
//        TipoTelefone::create(array('descricao' => 'Telefone Celular do Trabalho'));
//    */    echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
