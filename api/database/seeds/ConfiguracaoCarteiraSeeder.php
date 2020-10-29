<?php

use Illuminate\Database\Seeder;

class ConfiguracaoCarteiraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=ConfiguracaoCarteiraSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders ConfiguracaoCarteiraSeeder ***";
        $data = [
            ['id_conta_bancaria' => 1, 'id_carteira' => 1, 'id_layout_remessa' => 1, 'id_layout_retorno' => 1, 'agencia' => '4319', 'conta_corrente' => '28002-2', 'codigo_cedente' => '', 'primeiro_dado_config' => '', 'segundo_dado_config' => '', 'instru_cobranca_um' => '', 'instru_cobranca_dois' => '', 'instru_cobranca_tres' => '', 'nosso_numero_inicio' => '00001', 'nosso_numero_fim'=>'99999']
        ];
        foreach ($data as $dt) {
            \App\Models\ConfiguracaoCarteira::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
