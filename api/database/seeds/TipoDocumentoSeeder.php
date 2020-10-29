<?php

use Illuminate\Database\Seeder;

class TipoDocumentoSeeder extends Seeder
{
    public function run()
    {
        //php artisan db:seed --class=TipoDocumentoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders TipoDocumentoSeeder ***";
        $array = array("NOTA FISCAL", "BOLETO" , "RECIBO", "DARF", "TITULO");
        foreach ($array as $value) {
            \App\Models\TipoDocumento::create(["nome" =>$value]);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}