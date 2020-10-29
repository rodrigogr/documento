<?php

use Illuminate\Database\Seeder;

class BancoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //php artisan db:seed --class=BancoSeeder
        $start = microtime(true);
        echo "*** Iniciando os Seeders BancoSeeder ***";
        $data = [
            ['codigo' => '237', 'descricao' => 'BANCO BRADESCO', 'url' => 'https://banco.bradesco/html/classic/produtos-servicos/mais-produtos-servicos/segunda-via-boleto.shtm', 'img' => 'img/bancos/bradesco.png'],
            ['codigo' => '341', 'descricao' => 'BANCO ITAÚ S.A', 'url' => 'https://www.itau.com.br/servicos/boletos/segunda-via/', 'img' => 'img/bancos/itau.png'],
            ['codigo' => '001', 'descricao' => 'BANCO DO BRASIL', 'url' => 'https://www63.bb.com.br/portalbb/boleto/boletos/hc21e,802,3322,10343.bbx?_ga=2.25210302.2043215422.1511871573-1901821601.1511871573', 'img' => 'img/bancos/bb.png'],
            ['codigo' => '033', 'descricao' => 'BANCO SANTANDER', 'url' => 'https://www.santander.com.br/br/resolva-on-line/boletos', 'img' => 'img/bancos/santander.png'],
            ['codigo' => '104', 'descricao' => 'CAIXA ECONÔMICA FEDERAL', 'url' => 'https://bloquetoexpresso.caixa.gov.br/bloquetoexpresso/index.jsp', 'img' => 'img/bancos/caixa.png'],
            ['codigo' => '399', 'descricao' => 'BANCO HSBC', 'url' => 'http://www.hsbc.com', 'img' => 'img/bancos/hsbc.png'],
            ['codigo' => '748', 'descricao' => 'SICREDI', 'url' => 'https://si-web.sicredi.com.br/boletoweb/BoletoWeb.servicos.Index.task', 'img' => 'img/bancos/sicredi.png'],
            ['codigo' => '041', 'descricao' => 'BANCO BANRISUL', 'url' => 'https://ww8.banrisul.com.br/brb/link/Brbw2Lhw_Bloqueto_Titulos_Internet.aspx?SegundaVia=1&secao_id=2539', 'img' => 'img/bancos/banrisul.png'],
            ['codigo' => '756', 'descricao' => 'SICOOB', 'url' => 'http://www.sicoob.com.br/segunda-via-de-boleto/', 'img' => 'img/bancos/sicoob.png'],
            ['codigo' => '004', 'descricao' => 'BANCO BNB', 'url' => 'https://www.bnb.gov.br/servicos/emissao-da-2-via-do-boleto', 'img' => 'img/bancos/bnb.png']

        ];
        foreach ($data as $dt) {
            \App\Models\Banco::create($dt);
        }
        echo "\n*** Completo em " . round((microtime(true) - $start), 3) . "s ***\n";
    }
}
