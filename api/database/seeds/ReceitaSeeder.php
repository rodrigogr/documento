<?php

use Illuminate\Database\Seeder;

class ReceitaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=ReceitaSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders ReceitaSeeder ***";
        $data = [
            ['percentualmulta' => 1, 'percentualjuros'=>1,
                'modalidadejuro'=>'Juros Composto', 'periodicidadedojuro'=>'Mês',
                'incidircorrecao'=>1,'indicecorrecao'=>'IGMP', 'visualizarinstrucao'=>1,
                'instrucaosacado'=>'Cobrar multa de $MULTA e juros de $JUROS ao mês. Não receber após o dia $DATA_VENCIMENTO.',
                'localdepagamento'=>'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO', 'anexarprestacaodecontas'=>1, 'mesprestacaodeconta'=>1, 'versoboleto'=>0, 'tempoinadimplencia'=>4, 'valortolerancia'=>0,
                'id_configuracao_carteira'=>1, 'id_tipolancamentomulta'=>3, 'id_tipolancamentojuros'=>4, 'id_tipolancamentocorrecao'=>5,
                'id_tipolancamentocustasadicionais'=>6, 'id_tipolancamentodesconto'=>7, 'id_tipoinadimplenciapadrao' =>1,'id_tipolancamentoabatimento'=>8,'id_tipolancamentojuridico'=>9
            ]
        ];
        foreach ($data as $dt) {
            \App\Models\Receita::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***";
    }
}
