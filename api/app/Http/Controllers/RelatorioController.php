<?php


namespace App\Http\Controllers;


use App\Helpers\DataHelper;
use App\models\Assembleia\Assembleia;
use App\models\Assembleia\AssembleiaOpcao;
use App\models\Assembleia\AssembleiaVotacao;
use App\Models\Condominio;
use App\PrintPdf;
use Illuminate\Support\Facades\DB;

class RelatorioController
{
    private $html_reset_css =
        '<style>html, body, div, span, applet, object, iframe,
        h1, h2, h3, h4, h5, h6, p, blockquote, pre,
        a, abbr, acronym, address, big, cite, code,
        del, dfn, em, img, ins, kbd, q, s, samp,
        small, strike, strong, sub, sup, tt, var,
        b, u, i, center,
        dl, dt, dd, ol, ul, li,
        fieldset, form, label, legend,
        table, caption, tbody, tfoot, thead, tr, th, td,
        article, aside, canvas, details, embed, 
        figure, figcaption, footer, header, hgroup, 
        menu, nav, output, ruby, section, summary,
        time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            vertical-align: baseline;
        }
        /* HTML5 display-role reset for older browsers */
        article, aside, details, figcaption, figure, 
        footer, header, hgroup, menu, nav, section {
            display: block;
        }
        body {
            line-height: 1;
        }
        ol, ul {
            list-style: none;
        }
        blockquote, q {
            quotes: none;
        }
        blockquote:before, blockquote:after,
        q:before, q:after {
            content: \'\';
            content: none;
        }
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }</style>';

    public function contasAPagarSintetico(RelatorioContasPagarRequest $request){
        $data = $request->all();
        $data_ini = DataHelper::setDate($data["data_inicial"]);
        $data_fim = DataHelper::setDate($data["data_final"]);
        if (($data["data_inicial"] != "" && $data["data_final"] != "") || ($data["data_ini_pgto"]!="" && $data["data_ini_pgto"]!="")) {
            $Data = ParcelaPagar::join('lancamento_agendar as l', 'l.id', 'parcela_pagar.id_lancamento_agendar')
                ->join('tipo_lancamentos as t', 't.id', 'l.id_tipo_lancamento')
                ->join('grupo_lancamentos as g', 'g.id', 't.idgrupo_lancamento')
                ->select('g.id', 'g.descricao as grupo', 't.id as id_tipo', 't.descricao as tipo', 'l.mes_competencia', 'l.ano_competencia',
                    'parcela_pagar.data_base', 'parcela_pagar.tipo_operacao', \DB::raw('SUM(parcela_pagar.valor_pago) as valor_total'));
            //->whereBetween('parcela_pagar.data_base',[$data_ini,$data_fim]);
            if ($data["data_inicial"] != "") {
                $Data = $Data->whereBetween('parcela_pagar.data_base', [$data_ini, $data_fim]);
            }
            if ($data["operacao"] != "") {
                $Data = $Data->where('parcela_pagar.tipo_operacao', $data["operacao"]);
            }
            if ($data["data_ini_pgto"] != "") {
                $data_ini_pgto = DataHelper::setDate($data["data_ini_pgto"]);
                $data_fim_pgto = DataHelper::setDate($data["data_fim_pgto"]);
                $Data = $Data->whereBetween('parcela_pagar.data_pagamento', [$data_ini_pgto, $data_fim_pgto]);
            }
            $Data = $Data->groupBy('parcela_pagar.tipo_operacao')
                ->groupBy('l.id_tipo_lancamento')
                ->orderBy('g.id', 'ASC')
                ->orderBy('t.id', 'ASC')
                ->orderBy('parcela_pagar.tipo_operacao', 'ASC')
                ->get();
        } else {
            return response()->error('Necessario data (vencimento/pagamento) inicial e final.');
        }
        if (count($Data) == 0){
            return response()->error('Não foi encontrado nenhum resultado!');
        }
        $periodo_txt = $data["data_inicial"].' à '.$data["data_final"];
        //mostrar filtro no cabeçalho
        $filtro_data = $filtro_pgto = "";
        if($data["data_ini_pgto"] != "") {
            $filtro_pgto = "<br>pagamento de ".DataHelper::getPrettyDate($data["data_ini_pgto"]).' à '.DataHelper::getPrettyDate($data["data_fim_pgto"]);
            $filtro_topico = DataHelper::getPrettyDate($data["data_ini_pgto"]).' à '.DataHelper::getPrettyDate($data["data_fim_pgto"]);
        }
        if ($data["data_inicial"]) {
            $filtro_topico = $filtro_data = DataHelper::getPrettyDate($data["data_inicial"]).' à '.DataHelper::getPrettyDate($data["data_final"]);
        }
        $html = $this->html_reset_css;
        $html .= $this->pdf_cabecalho('Relatório Contas a Pagar - Sintético',$filtro_data.$filtro_pgto);
        $html .= "<style>th{ background-color: #f1f1f1;padding: 3px 3px;border-right: 1px solid #929292;} td{ padding: 3px;}</style>";
        $html .= "<table style='width: 100%;'><tbody>";
        $aux = 0;
        $valor_total = 0;
        $valor_total_debito = 0;
        $valor_total_provisao = 0;
        foreach ($Data as $item){
            if($aux == 0 || $aux != $item->id) {
                $html .= "<tr><td>&nbsp;</td></tr>";
                $html .= "<tr><th style='text-align:center' colspan='4'>Grupo&nbsp;&nbsp;&nbsp;" . $item->grupo . "</th></tr>";
                $html .= "<tr>
                            <th style='width: 20%'>Período</th>
                            <th style='width: 20%;'>Situação Pagamento</th>
                            <th style='width: *;text-align:center;'>Tipo Lançamento</th>
                            <th style='width: 10%;text-align:center;'>Valor (R$)</th>
                          </tr>";
                $aux = $item->id;
            }
            $html .= "<tr>
                        <td style='text-align:center;'>" . $filtro_topico . "</td>                
                        <td style='text-align:center;'>" . $item->tipo_operacao . "</td>                
                        <td>" . $item->tipo . "</td>
                        <td style='text-align:center;'>" . DataHelper::getDoubleToReal($item->valor_total) . "</td>                
                      </tr>";
            $valor_total += $item->valor_total;
            if($item->tipo_operacao == 'Débito'){
                $valor_total_debito += $item->valor_total;
            }
            if($item->tipo_operacao == 'Provisão'){
                $valor_total_provisao += $item->valor_total;
            }
        }
        $html .= "<tr><td>&nbsp;</td></td></tr>
                  <tr><td colspan='2'>Total de <b>".count($Data)."</b> registros</td></tr>";
        if($data["operacao"] == "") {
            $html .= "<tr><td colspan='4' style='font-weight: bold; text-align:right;padding-right: 5px;'>Valor total Débito: R$ ".DataHelper::getDoubleToReal($valor_total_debito)."</td></tr>";
            $html .= "<tr><td colspan='4' style='font-weight: bold; text-align:right;padding-right: 5px;'>Valor total Provisão: R$ ".DataHelper::getDoubleToReal($valor_total_provisao)."</td></tr>";
        }
        $html .= "<tr><td colspan='4' style='font-weight: bold; text-align:right;padding-right: 5px;'>Valor total: R$ ".DataHelper::getDoubleToReal($valor_total)."</td></tr>";
        $html .= "</tbody></table>";
        $footer = $this->pdf_footer('Relatório Contas a Pagar - Sintético');

        //return response($html);
        $mpdf = new PrintPdf('', 'A4', 7, 'FreeSans', 5, 5, 10, 15, 8, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output('rel_contas_pagar_sintetico','I'));
    }

    public  function pdf_cabecalho($titulo,$subtitulo = null){
        $condominio = Condominio::first();

        if(!is_null($subtitulo)){
            $subtitulo = '<br><p>'.$subtitulo.'</p>';
        }

        $pdf_header = $this->html_reset_css;
        $pdf_header .= "<style>th{ padding:5px 0px;} td{ padding: 3px 0px;}</style>";
        $exists = \Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        $pdf_header .= "<table style='width: 100%;'>
                            <tr>
                                <td style='vertical-align: top'>
                                    <img style='padding: 1px;width: 80px;' src='".$path_logo."'><br>
                                    <h3>".$condominio->nome_fantasia."</h3>
                                </td>
                                <td style='text-align:center; vertical-align: bottom;'>
                                    <h2 style='font-size: 20px;text-align:center;padding-bottom: 10px; '>".$titulo."</h2>
                                    ".$subtitulo."
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                       </table>";
        return $pdf_header;
    }

    public function pdf_footer($titulo){
        $pdf_footer = '<table width="100%" style="vertical-align: bottom; font-family: serif; font-size: 6px; color: #000000; font-style: italic;">
                    <tr>
                        <td width="33%"><span style="font-style: italic;">{DATE d/m/Y - H:i:s}</span></td>
                        <td width="33%" align="center" style="font-style: italic;">{PAGENO} de {nbpg}</td>
                        <td width="33%" style="text-align:center;">' .$titulo.'</td>
                    </tr>
                    </table>';
        return $pdf_footer;
    }

    public function contasAPagar(RelatorioContasPagarRequest $request){
        $data = $request->all();

        if (($data["data_inicial"] != "" && $data["data_final"] != "") || ($data["data_ini_pgto"]!="" && $data["data_ini_pgto"]!="")) {
            $Data = GrupoLancamento::with(['tipo_lancamentos' => function ($q) use ($data) {
                $q->whereHas('lancamentos_by_tipo_lancamento', function ($q) {
                    //este whereHas vazio é apenas para pesquisar os tipo_lancamentos que contém algum lancamento_agendar
                    $q->orderBy('data_base', 'ASC');
                });
                $q->with(['lancamentos_by_tipo_lancamento' => function ($q) use ($data) {
                    $q->with(['parcelas' => function ($q) use ($data) {
                        if ($data["data_inicial"] != "") {
                            $data_ini = DataHelper::setDate($data["data_inicial"]);
                            $data_fim = DataHelper::setDate($data["data_final"]);
                            $q->whereBetween('data_base', [$data_ini, $data_fim]);
                        }
                        if ($data["operacao"] != "") {
                            $q->where('tipo_operacao', $data["operacao"]);
                        }
                        if ($data["data_ini_pgto"] != "") {
                            $data_ini_pgto = DataHelper::setDate($data["data_ini_pgto"]);
                            $data_fim_pgto = DataHelper::setDate($data["data_fim_pgto"]);
                            $q->whereBetween('data_pagamento', [$data_ini_pgto, $data_fim_pgto]);
                        }
                        $q->orderBy('data_base', 'ASC');
                    }]);
                    $q->with('empresa');
                }]);
            }])
                ->orderBy('descricao', 'asc')
                ->get();
        } else {
            return response()->error('Necessario data (vencimento/pagamento) inicial e final.');
        }
        $filtro_data = $filtro_pgto = "";
        if ($data["data_inicial"]) {
            $filtro_data = DataHelper::getPrettyDate($data["data_inicial"]).' à '.DataHelper::getPrettyDate($data["data_final"]);
        }
        if($data["data_ini_pgto"] != "") {
            $filtro_pgto = "<br>pagamento de ".DataHelper::getPrettyDate($data["data_ini_pgto"]).' à '.DataHelper::getPrettyDate($data["data_fim_pgto"]);
        }

        $html = $this->html_reset_css;
        $html .= $this->pdf_cabecalho('Relatório Contas a Pagar - Detalhado',$filtro_data.$filtro_pgto);
        $html .= "<style>th{ background-color: #f1f1f1;padding: 3px 3px;border-right: 1px solid #929292;} td{ padding: 3px;}</style>";
        $html .= "<table style='width: 100%;'><tbody>";

        $i = 0;
        $valor_total = 0;
        foreach ($Data as $item){
            $x = 0;
            foreach ($item->tipo_lancamentos as $tipo_lancamento){
                foreach ($tipo_lancamento->lancamentos_by_tipo_lancamento as $lancamentos){
                    foreach ($lancamentos->parcelas as $parcela) {
                        if($x == 0){
                            $html .= "<tr><td>&nbsp;</td></tr>";
                            $html .= "<tr><th style='text-align:center' colspan='8'>Grupo&nbsp;&nbsp;".$item->descricao."</th></tr>";
                            $html .= "<tr>
                            <th style='width: 7%'>Mês/Ano</th>
                            <th style='width: 11%'>Dt.Vencimento</th>
                            <th style='width: 11%'>Dt.Pagamento</th>
                            <th style='width: 13%'>Dt.Compensação</th>
                            <th style='width: *;text-align:center;'>Fornecedor</th>
                            <th style='width: 23%;text-align:center;'>Tipo Lançamento</th>
                            <th style='width: *;text-align:center;'>Descrição</th>
                            <th style='width: *'>Valor(R$)</th>
                          </tr>";
                        }
                        $html .= "<tr>
                                    <td style='text-align:center;'>" . $lancamentos->mes_competencia . "/" . $lancamentos->ano_competencia . "</td>                
                                    <td style='text-align:center;'>".$parcela->data_base."</td>                
                                    <td style='text-align:center;'>".$parcela->data_pagamento."</td>                
                                    <td style='text-align:center;'>".$parcela->data_compensacao."</td>                
                                    <td>".$lancamentos->empresa->nome_fantasia."</td>
                                    <td>".$tipo_lancamento->descricao."</td>                
                                    <td>".$lancamentos->descricao."</td>                
                                    <td style='text-align:center;'>".DataHelper::getDoubleToReal($parcela->valor_pago)."</td>                
                                  </tr>";
                        $valor_total += $parcela->valor_pago;
                        $x++;
                        $i++;
                    }
                }
            }

        }
        if ($i == 0){
            return response()->error('Nenhum resultado foi encontrado!');
        }
        $html .= "<tr><td>&nbsp;</td></td></tr>
                  <tr style='background-color: #F1F1F1'>
                    <td colspan='2'>Total de <b>$i</b> registros</td>
                    <td colspan='6' style='font-weight: bold; text-align:right'>Valor total: R$ ".DataHelper::getDoubleToReal($valor_total)."</td>
                  </tr>";
        $html .= "</tbody></table>";
        $footer = $this->pdf_footer('Relatório Contas a Pagar - Detalhado');
        //return response($html);
        $mpdf = new PrintPdf('', 'A4', 7, 'FreeSans', 5, 5, 10, 15, 8, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);
        return response($mpdf->Output());
    }

    public function titulosProvisionados(ReceitaTituloProvisionadoRequest $request)
    {

        set_time_limit(0);
        ini_set('memory_limit','512M');
        $data = $request->all();

        $data_inicial = DataHelper::setDate($data["data_inicial"]);
        $data_final   = DataHelper::setDate($data["data_final"]);

        $competencia = explode(' / ',$data["competencia"]);

        $valor_total = 0;
        $valor_titulo = 0;
        $valor_lancamentos = 0;
        $descontos = 0;
        $total_lancamento = array();

        $Data = ParcelaBoleto::whereHas('parcela', function($q) use($data){
            $q->doesntHave('parcelasAcordo');
            $q->where('valor','>',0);
            if ($data['somente_taxas'] || (!empty($data["lote"]) && !empty($data["quadra"]))) {
                $q->whereHas('recebimento', function ($q) use($data) {
                    if(!empty($data["lote"]) && !empty($data["quadra"])) {
                        $q->whereHas('imovel', function ($q) use($data) {
                            $q->where('quadra',$data["quadra"]);
                            $q->where('lote',$data["lote"]);
                        });
                    }
                    if($data["somente_taxas"]) {
                        $q->whereHas('lancamentos', function ($q) {
                            $q->whereHas('lancamento', function ($q) {
                                $q->where('categoria', 1);
                            });
                        });
                    }
                });
            }
        })->with(['parcela' => function($q) {
            $q->select('id','id_recebimento','valor','valor_origem');
            $q->with(['recebimento' => function($q) {
                $q->select('id','idimovel','idassociado');
                $q->with(['lancamentos' => function($q) {
                    $q->with('lancamento');
                }]);
                $q->with(['associado' => function($q) {
                    $q->select('id','nome');
                }]);
                $q->with(['imovel' => function($q) {
                    $q->select('id','quadra','lote');
                }]);
            }]);
        }]);
        if ($data["somente_taxas"]) {
            $Data = $Data->whereRaw('EXTRACT(YEAR_MONTH FROM data_vencimento_origem) = '.$competencia[1].$competencia[0]);
        } else {
            $Data = $Data->whereBetween('data_vencimento',[$data_inicial,$data_final]);
        }
        $Data = $Data->whereNotIn('situacao', ['Cancelado,Negociado'])
            ->whereNull('deleted_at')
            ->select('id_parcela','data_vencimento','data_vencimento_origem','nosso_numero')
            ->orderBy('data_vencimento')
            ->get();

        if ($Data->count() == 0){
            return response()->error('Não foi encontrado nenhum resultado!');
        }

        $periodo_apurado = $data["somente_taxas"] ? $data["competencia"]: $data["data_inicial"].' à '.$data["data_final"];
        $html = $this->pdf_cabecalho('Relatório de Títulos Provisionados',$periodo_apurado);
        $footer = $this->pdf_footer('Relatório de Títulos Provisionados');
        $html .= "<table style='border-collapse: collapse; width: 100%;'><tbody>";


        $html .= "<tr style='background-color: #EAEAEA;'>
                        <th style='width: 5%'>Dt. Venc</th>
                        <th style='width: 10%'>Competência</th>
                        <th style='width: 10%'>Quadra/Lote</th>
                        <th style='width: 50%;text-align:center'>Associado</th>
                        <th style='width: 15%'>Nosso Número</th>
                        <th style='width: 10%;text-align:center;padding-right: 7px;'>Valor</th>
                      </tr>";
        $i = 0;
        foreach ($Data as $item){
            $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';
            $valor_titulo = ($data["valores"] == 'origem') ? $item->parcela->valor_origem : $item->parcela->valor;
            $html .= "
                      <tr style='background-color: $c'>
                        <td style='text-align:center;'>".DataHelper::getPrettyDate($item->data_vencimento)."</td>
                        <td style='text-align:center;width: 15%;'>".DataHelper::getPrettyDate($item->data_vencimento_origem)."</td>
                        <td style='text-align:center'>".$item->parcela->recebimento->imovel->quadra."/".$item->parcela->recebimento->imovel->lote."</td>
                        <td style='width: 30%'>".$item->parcela->recebimento->associado->nome."</td>
                        <td style='text-align:center'>".$item->nosso_numero."</td>
                        <td style='text-align:center;padding-right: 7px;'>R$ ".DataHelper::getDoubleToReal($valor_titulo)."</td>
                      </tr>";
            $i++;
            $valor_total += $valor_titulo;
            foreach ($item->parcela->recebimento->lancamentos as $lancs) {
                if ($lancs->lancamento->categoria == 7 || $lancs->lancamento->categoria == 10) {
                    $descontos += $lancs->lancamento->valor;
                } else {
                    $valor_lancamentos += $lancs->lancamento->valor;
                }
                if (!isset($total_lancamento[$lancs->lancamento->categoria])) $total_lancamento[$lancs->lancamento->categoria]["valor"] = 0;
                $total_lancamento[$lancs->lancamento->categoria]["valor"] = $total_lancamento[$lancs->lancamento->categoria]["valor"] + $lancs->lancamento->valor;
                $total_lancamento[$lancs->lancamento->categoria]["categoria"] = EnumCategoriaLancamento::toString($lancs->lancamento->categoria);
            }
        }
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr><td colspan='2'><i>Total de $i registros</i></td></tr>";
        $html .= "<tr><td>&nbsp;</td></tr>";

        //valor total do período
        foreach ($total_lancamento as $key => $item) {
            $sinal = ($key == 7 || $key == 10) ? '-' : '';
            $html .= "<tr><td colspan='6' style='font-weight: bold; text-align:right'>Total ".$item["categoria"].": R$ ".$sinal.DataHelper::getDoubleToReal($item["valor"])."</td></tr>";
        }
        $html .= "<tr><td colspan='6' style='font-weight: bold; text-align:right'>Valor total: R$ ".DataHelper::getDoubleToReal($valor_total)."</td></tr>";
        $html .= "</tbody></table>";

        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 5, 15, 10, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function inadimplenciaSituacao(Request $request)
    {
        set_time_limit(0);
        ini_set('memory_limit','940M');
        $data = $request->all();
        $data_ini = DataHelper::setDate($data["data_inicial"]);
        $data_fim = DataHelper::setDate($data["data_final"]);

        $Data = Recebimento::whereHas('parcelas',function($q) use($data_ini,$data_fim,$data) {
            $q->with('parcelasBoleto')->whereHas('parcelasBoleto', function($q) use($data_ini,$data_fim,$data){
                $q->whereBetween('data_vencimento',[$data_ini,$data_fim]);
                $q->where('data_vencimento','<',\DB::raw('CURDATE()'));
                if (!$data["periodo_congelado"]) {
                    $q->where('situacao', 'Provisionado');
                }
            });
            if ($data["periodo_congelado"]) {
                $q->whereRaw('(data_recebimento > \''.$data_fim.'\' or data_recebimento IS NULL)');
            } else {
                $q->whereNull('data_recebimento');
            }
            if($data["situacao_cobranca"] != ""){
                $q->where('id_situacao_inadimplencia',$data["situacao_cobranca"]);
            }
        })
            ->with(['parcelas' => function($q) use($data_ini,$data_fim,$data){
                $q->select('id','id_recebimento','valor','valor_recebido','data_recebimento','id_situacao_inadimplencia');
                $q->with('parcelasBoleto')->whereHas('parcelasBoleto', function($q) use($data_ini,$data_fim,$data){
                    $q->whereBetween('data_vencimento',[$data_ini,$data_fim]);
                    if (!$data["periodo_congelado"]) {
                        $q->where('situacao', 'Provisionado');
                    }
                    $q->select('id_parcela','data_vencimento','nosso_numero','situacao');
                });
                $q->with(['situacaoInadimplencia' => function($q){
                    $q->select('id','idtipo_inadimplencia','descricao');
                    $q->with(['tipo_inadimplencia' => function($q){
                        $q->select('id','descricao');
                    }]);
                }]);
            }])
            ->with(array('associado' => function($q1){
                $q1->select('id','nome');
            }))
            ->with(array('lancamentos' => function($q3){
                $q3->with(array('lancamento' => function($q){
                    $q->select('id','valor','descricao','categoria');
                }));
            }))
            ->with(['acordo' => function($q){
                $q->where('status',1);
                $q->select('id','id_recebimento','data_acordo');
            }])
            ->join('imovel as i','i.id','recebimentos.idimovel')
            ->select('recebimentos.id','recebimentos.idimovel','recebimentos.idassociado','recebimentos.numero_parcelas','i.quadra','i.lote')
            ->orderBy(\DB::raw('ABS(quadra)'),'ASC')
            ->orderBy(\DB::raw('ABS(lote)'),'ASC');

        if ($data["quadra"] != "" && $data["lote"] != "" ){
            $Data = $Data->where('i.quadra',\DB::raw('ABS('.$data["quadra"].')'))->where('i.lote',\DB::raw('ABS('.$data["lote"].')'));
        }
        $Data = $Data->get();
//        return $Data;

        if (count($Data) == 0){
            return response()->error('Não foi encontrado nenhum resultado!');
        }
        $html = $this->pdf_cabecalho('Relatório Analítico de Inadimplentes <br> - Situação Inadimplência -',DataHelper::getPrettyDate($data["data_inicial"]).' à '.DataHelper::getPrettyDate($data["data_final"]));
        $html_css = "<style>th{ color:#FFF; } .totais td{font-weight: bold;}</style>";
        $html .= $html_css;
        $footer = $this->pdf_footer('Relatório de Inadimplentes Analítico');
        $html .= "<table style='border-collapse: collapse; width: 100%;'><tbody>";

        ###############  NOVO  ###########################
        $assoc = '';
        $i = 0;
        foreach ( $Data as $key => $item) {

            if ($item->idassociado != $assoc) {
                //cabeçalho de acordo com a quadra e lote
                $html .= '<tr style="background-color: #666;">
                    <th style="text-align:center">Quadra.' . $item["quadra"] . ' Lote.' . $item["lote"] . '</th>
                    <th>Nosso Nº</th>
                    <th style="text-align:right">Dt. Venc.</th>                            
                    <th>Descrição</th>
                    <th></th>
                    <th></th>
                    <th>Valor</th>
                  </tr>';
            } else {
                $html .= '<tr>
                        <td style="font-size: 2px"><hr></td>                    
                        </tr>';
            }
            foreach ($item->parcelas as $parcela) {
                $html .= '<tr>
                        <td style="width: 30%">' . $item->associado->nome.'</td>
                        <td style="text-align:center">' . $parcela->parcelasBoleto->nosso_numero . '</td>
                        <td style="text-align:right">' . $parcela->parcelasBoleto->data_vencimento . '</td>
                        <td style="text-align:center"></td>
                        <td style="text-align:center"></td>
                        <td style="text-align:center"></td>
                        <td style="text-align:center"></td>
                      </tr>
                      <tr>
                        <td><b style="font-size: 10px; ">Situa.: '.strtolower(camel_case($parcela->situacaoInadimplencia->tipo_inadimplencia->descricao).' 
                                    '.strtolower($parcela->situacaoInadimplencia->descricao)).'</b></td>
                      </tr>';
                if(count($item["acordo"]) == 0) {
                    foreach ($item->lancamentos as $lancamentos) {
                        if ($lancamentos["lancamento"]["valor"] > 0) {
                            $valor = $item->numero_parcelas > 1 ? ($lancamentos["lancamento"]["valor"] / $item->numero_parcelas) : $lancamentos["lancamento"]["valor"];
                            $html .= '<tr>
                                <td></td>             
                                <td></td>             
                                <td></td>             
                                <td colspan="3">' . $lancamentos["lancamento"]["descricao"] . '</td>             
                                <td style="text-align:center">' . DataHelper::getDoubleToReal($valor) . '</td>             
                              </tr>';
                        }
                        unset($valor);
                    }
                } else {
                    $html .= '<tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3">Parcela de acordo firmado em '.$item->acordo[0]->data_acordo.'</td>
                                <td style="text-align:center">' . DataHelper::getDoubleToReal($parcela->valor) . '</td>
                            </tr>';
                }
                $html .= '<tr class="totais">
                            <td colspan="2">&nbsp;</td>
                            <td style="text-align:center"></td>
                            <td style="text-align:center"></td>
                            <td style="text-align:center"></td>
                            <td style="text-align:center">Total</td>
                            <td style="text-align:center">' . DataHelper::getDoubleToReal($parcela->valor) . '</td>
                          </tr>';
                $i++;
            }
            $assoc = $item->idassociado;
        }

        $html .= '<tr><td style="padding-top: 30px"><b>Total de '.$i.' registros</b></td></td></tr>';

        $html .= "</tbody></table>";
        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 10, 15, 1, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        /*$memory = memory_get_usage();
        $mb = $this->bytes_to_mb($memory);
        \Log::debug('FINAL----> '.$mb.' megabytes');*/

        return response($mpdf->Output());
    }

    public function inadimplencia(ReceitaTituloProvisionadoRequest $request){
        set_time_limit(0);
        ini_set('memory_limit','512M');
        $data = $request->all();
        $data_inicial = DataHelper::setDate($data["data_inicial"]);
        $data_final   = DataHelper::setDate($data["data_final"]);
        $valor_total = 0;

        $competencia = explode(' / ',$data["competencia"]);

        $Data = ParcelaBoleto::join('recebimento_parcelas as rp','parcela_boletos.id_parcela','=','rp.id')
            ->join('recebimentos as r','r.id','rp.id_recebimento')
            ->join('pessoa as pe','r.idassociado','pe.id')
            ->join('imovel as i','r.idimovel','i.id')
            ->join('situacao_inadimplencias as s','s.id','rp.id_situacao_inadimplencia')
            ->where('parcela_boletos.data_vencimento','<', \DB::raw('CURDATE()'))
            ->whereNull('parcela_boletos.deleted_at');
        ;

        if($data["somente_taxas"]){
            $Data = $Data->join('recebimento_lancamentos', 'r.id','recebimento_lancamentos.id_recebimento')
                ->join('lancamentos_contas_receber','recebimento_lancamentos.id_lancamento_receber','lancamentos_contas_receber.id')
                ->join('lancamentos','lancamentos_contas_receber.id_lancamento','lancamentos.id')
                ->where('lancamentos.categoria',1)
            ;
            $Data = $Data->whereRaw('EXTRACT(YEAR_MONTH FROM data_vencimento_origem) = '.$competencia[1].$competencia[0]);
        } else {
            $Data = $Data->whereBetween('parcela_boletos.data_vencimento',[$data_inicial,$data_final]);
        }
        if($data["periodo_congelado"]){
            $Data = $Data->whereRaw('(rp.data_recebimento > \''.$data_final.'\' or rp.data_recebimento IS NULL)');
        } else {
            $Data = $Data->where('parcela_boletos.situacao','Provisionado');
        }
        if ($data["quadra"] != "" && $data["lote"] != "" ){
            $Data = $Data->where('i.quadra',\DB::raw('ABS('.$data["quadra"].')'))->where('i.lote',\DB::raw('ABS('.$data["lote"].')'));
        }
        if($data["situacao_cobranca"] != ""){
            $Data = $Data->where('s.id',$data["situacao_cobranca"]);
        }

        $Data = $Data->select('parcela_boletos.id_parcela','parcela_boletos.data_vencimento','rp.data_recebimento','pe.nome as associado','parcela_boletos.nosso_numero',
            'i.quadra','i.lote','rp.valor',\DB::raw('DATE_FORMAT(parcela_boletos.data_vencimento_origem,"%m/%Y") as competencia'), 's.idtipo_inadimplencia',
            's.descricao as sit_inadimplencia')
            ->groupBy('parcela_boletos.id_parcela')
            ->orderBy('i.quadra','ASC')
            ->orderBy(\DB::raw('ABS(i.lote)'),'ASC')

            ->get();

        if ($Data->count() == 0){
            return response()->error('Não foi encontrado nenhum resultado!');
        }
        if($data["somente_taxas"]){
            $html = $this->pdf_cabecalho('Relatório de Inadimplentes','Competência '.$competencia[0]."/".$competencia[1]);
        } else {
            $html = $this->pdf_cabecalho('Relatório de Inadimplentes',$data["data_inicial"].' à '.$data["data_final"]);
        }

        $footer = $this->pdf_footer('Relatório de Inadimplentes');
        $html .= "<table style='border-collapse: collapse; width: 100%;'><tbody>";

        $i = 0;
        $html .= "<tr style='background-color: #EAEAEA;'>
                        <th style='width:7%'>Dt. Venc</th>
                        <th style='width: 10%'>Competência</th>
                        <th style='width: 10%'>Situação</th>
                        <th style='width: auto;text-align:center'>Associado</th>
                        <th style='width: 15%'>Nosso Número</th>
                        <th style='width: 10%'>Quadra/Lote</th>
                        <th style='width: 10%;text-align:center;padding-right: 7px;'>Valor</th>
                      </tr>";
        foreach ($Data as $item){
            $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';
            $html .= "
                      <tr style='background-color: $c'>
                        <td style='text-align:center;'>".DataHelper::getPrettyDate($item->data_vencimento)."</td>
                        <td style='text-align:center;'>".$item->competencia."</td>
                        <td style='text-align:left;'>".TipoInadimplencia::find($item->idtipo_inadimplencia)->descricao." ".$item->sit_inadimplencia."</td>
                        <td style='text-align:center;'>".$item->associado."</td>
                        <td style='text-align:center'>".$item->nosso_numero."</td>
                        <td style='text-align:center'>".$item->quadra."/".$item->lote."</td>
                        <td style='text-align:center;padding-right: 7px;'>R$ ".DataHelper::getDoubleToReal($item->valor)."</td>
                      </tr>";
            $valor_total = ($valor_total + $item->valor);
            $i++;
        }
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr><td colspan='2'><i>Total de $i registros</i></td></tr>";
        $html .= "<tr><td>&nbsp;</td></tr>";

        //valor total do período
        $html .= "<tr><td colspan='7' style='font-weight: bold; text-align:right'>Valor total: R$ ".DataHelper::getDoubleToReal($valor_total)."</td></tr>";
        $html .= "</tbody></table>";

        //return response($html);
        $mpdf = new PrintPdf('', '', 7, '', 5, 5, 15, 15, 1, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output('nomePdf','I'));
    }

    public function titulosRecebidos(ReceitaTituloRecebidosRequest $request)
    {
        set_time_limit(0);
        ini_set('memory_limit','1024M');
        $data = $request->all();
        $data_ini = DataHelper::setDate($data["data_inicial"]);
        $data_fim = DataHelper::setDate($data["data_final"]);
        $data_pgto_inicial = DataHelper::setDate($data["data_pgto_inicial"]);
        $data_pgto_final = DataHelper::setDate($data["data_pgto_final"]);
        $quadra = $data["quadra"];
        $lote = $data["lote"];

        $DataQuery = Recebimento::whereHas('parcelas', function($q) use ($data, $data_ini, $data_fim, $data_pgto_inicial, $data_pgto_final) {
            $q->whereHas('parcelasBoleto', function($q) use($data, $data_ini, $data_fim) {
                $q->where('situacao','Compensado');
                if ($data["data_inicial"] != "") {
                    $q->whereBetween('data_vencimento', [$data_ini, $data_fim]);
                }
            });
            if ($data["data_pgto_inicial"] != "") {
                $q->whereBetween('recebimento_parcelas.data_recebimento', [$data_pgto_inicial, $data_pgto_final]);
            }
            $q->where('recebimento_parcelas.valor_recebido', '>', 0);
        });
        if ($lote !="" && $quadra !="") {
            $DataQuery = $DataQuery->whereHas('imovel', function($q) use($quadra,$lote) {
                $q->where('quadra',\DB::raw(abs($quadra)));
                $q->where('lote',\DB::raw(abs($lote)));
            });
            $DataQuery = $DataQuery->with('imovel');
        }
        if ($data["lancamentoAvulso"] === 'juridico') {
            $DataQuery = $DataQuery->whereHas('lancamentos', function ($q) {
                $q->whereHas('lancamento', function($q) {
                    $q->where('categoria','=',8);
                    $q->where('valor','>',0);
                });
            });
        }
        if ($data["lancamentoAvulso"] === 'avulso') {
            $DataQuery = $DataQuery->whereHas('lancamentos', function ($q) {
                $q->join('lancamento_avulsos', 'lancamento_avulsos.id_lancamento', 'lancamentos_contas_receber.id_lancamento');
            });
        }
        if ($data["lancamentoAvulso"] == 'gerados') {
            $DataQuery = $DataQuery->whereHas('lancamentos', function ($q) {
                $q->whereNotIn('lancamentos_contas_receber.id_lancamento', [\DB::raw('select id_lancamento from lancamento_avulsos')]);
            });
        }
        $DataQuery = $DataQuery->with(array('lancamentos' => function ($q) {
            $q->with('lancamento');
        }))
            ->with(['parcelas' => function($q) use ($data, $data_ini, $data_fim, $data_pgto_inicial, $data_pgto_final) {
                if ($data["data_pgto_inicial"] != "") {
                    $q->whereBetween('data_recebimento', [$data_pgto_inicial, $data_pgto_final]);
                }
                $q->whereHas('parcelasBoleto', function($q) use($data,$data_ini, $data_fim){
                    $q->where('situacao','Compensado');
                    if ($data["data_inicial"] != "") {
                        $q->whereBetween('data_vencimento', [$data_ini, $data_fim]);
                    }
                });
                $q->with('parcelasBoleto');
            }])
            ->select('recebimentos.id', 'recebimentos.idimovel', 'recebimentos.idassociado', 'recebimentos.numero_parcelas')
            ->orderBy('recebimentos.idimovel')
            ->get();
        if (!count($DataQuery)) {
            return response()->error('Nenhum resultado encontrado!');
        }
        // mostra período filtrado no cabeçalho
        $filtro_data = $filtro_pgto = "";
        if($data["data_inicial"] != ""){
            $filtro_data = 'vencimento de '.DataHelper::getPrettyDate($data_ini).' à '.DataHelper::getPrettyDate($data_fim);
        }
        if($data["data_pgto_inicial"] != ""){
            $filtro_pgto = '<br>pagamentos de '.DataHelper::getPrettyDate($data_pgto_inicial).' à '.DataHelper::getPrettyDate($data_pgto_final);
        }
        $html = $this->pdf_cabecalho('Relatório de Recebimentos',$filtro_data.$filtro_pgto);
        $html .= "<table style=' width: 100%;'><tbody>";
        $i = 0;
        $html .= "<tr style='background-color: #EAEAEA;'>
                        <th style=''>Associado</th>
                        <th style='width: 6%'>Nosso<br>Número</th>
                        <th style='width: 6%'>Quadra/Lote</th>
                        <th style='width: 6%'>Data Vencto</th>
                        <th style='width: 6%'>Data Pgto</th>
                        <th style='width: 6%'>Taxa<br>Manutenção</th>
                        <th style='width: 6%'>Fundo<br>Reserva</th>
                        <th style='width: 6%'>Outros<br>Lançamentos</th>
                        <th style='width: 6%'>Multa</th>
                        <th style='width: 6%'>Juros</th>
                        <th style='width: 6%'>Jurídico</th>
                        <th style='width: 6%'>Custas</th>
                        <th style='width: 6%'>Descontos</th>
                        <th style='width: 6%'>Abatimento</th>
                        <th style='width: 6%'>Correção</th>
                        <th style='width: 6%;text-align:center;'>A<br>receber</th>
                        <th style='width: 6%;text-align:center;padding-right: 7px;'>Recebido</th>
                      </tr>";
        $valor_taxa = $valor_fundo = $valor_outros = $valor_juridico = $valor_custas
            = $valor_descontos = $valor_juros = $valor_multa = $valor_correcao = $valor_abatimento = 0;
        $total_taxas = $total_fundo = $total_outros = $total_juridico = $total_custas
            = $total_descontos = $total_juros = $total_multa = $total_recebido = $total_a_receber = $total_correcao = $total_abatimento = 0;

        foreach ($DataQuery as $item) {

            foreach ($item->lancamentos as $list_lancamentos){
                if (isset($list_lancamentos->lancamento->categoria)) {
                    switch ($list_lancamentos->lancamento->categoria) {
                        case 1:
                            $valor_taxa += $list_lancamentos->lancamento->valor;
                            break;
                        case 2:
                            $valor_fundo += $list_lancamentos->lancamento->valor;
                            break;
                        case 3:
                            $valor_outros += $list_lancamentos->lancamento->valor;
                            break;
                        case 4:
                            $valor_custas += $list_lancamentos->lancamento->valor;
                            break;
                        case 5:
                            $valor_multa += $list_lancamentos->lancamento->valor;
                            break;
                        case 6:
                            $valor_juros += $list_lancamentos->lancamento->valor;
                            break;
                        case 7:
                            $valor_descontos += $list_lancamentos->lancamento->valor;
                            break;
                        case 8:
                            $valor_juridico += $list_lancamentos->lancamento->valor;
                            break;
                        case 9:
                            $valor_correcao += $list_lancamentos->lancamento->valor;
                            break;
                        case 10:
                            $valor_abatimento += $list_lancamentos->lancamento->valor;
                            break;
                    }
                }
            }


            $aux = 0;
            foreach ($item->parcelas as $parcela) {
                \Log::debug($item->id.' : '.$aux);
                if ($item->numero_parcelas > 1 && $aux != $item->id ){
                    $num_parc = $item->numero_parcelas;
                    $valor_taxa = $valor_taxa/$num_parc;
                    $valor_fundo = $valor_fundo/$num_parc;
                    $valor_juridico = $valor_juridico/$num_parc;
                    $valor_custas = $valor_custas/$num_parc;
                    $valor_multa = $valor_multa/$num_parc;
                    $valor_juros = $valor_juros/$num_parc;
                    $valor_descontos = $valor_descontos/$num_parc;
                    $valor_correcao = $valor_correcao/$num_parc;
                    $valor_abatimento = $valor_abatimento/$num_parc;
                    $valor_outros = $valor_outros/$num_parc;
                }
                $aux = $item->id;
                $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';
                $html .= "
                      <tr style='background-color: $c'>
                        <td style='width: 23%'>" . $item->associado->nome . "</td>
                        <td style='text-align:center'>" . $parcela->parcelasBoleto->nosso_numero . "</td>
                        <td style='text-align:center'>" . $item->imovel->quadra . "/" . $item->imovel->lote . "</td>
                        <td style='text-align:center'>" . $parcela->parcelasBoleto->data_vencimento . "</td>
                        <td style='text-align:center'>" . $parcela->data_recebimento . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_taxa) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_fundo) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_outros) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_multa) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_juros) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_juridico) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_custas) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_descontos) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_abatimento) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($valor_correcao) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($parcela->valor) . "</td>
                        <td style='text-align:center'>" . DataHelper::getDoubleToReal($parcela->valor_recebido) . "</td>
                      </tr>";
                $i++;
                //calculando os totais
                $total_a_receber += round($parcela->valor,2);
                $total_recebido += round($parcela->valor_recebido,2);
                $total_taxas += $valor_taxa;
                $total_fundo += $valor_fundo;
                $total_outros += $valor_outros;
                $total_custas += $valor_custas;
                $total_juridico += $valor_juridico;
                $total_juros += $valor_juros;
                $total_multa += $valor_multa;
                $total_descontos += $valor_descontos;
                $total_abatimento += $valor_abatimento;
                $total_correcao += $valor_correcao;
            }
            //reset valores dos lançamentos
            $valor_taxa = $valor_fundo = $valor_outros = $valor_juridico = $valor_custas = $valor_descontos = $valor_juros = $valor_multa = $valor_abatimento = $valor_correcao = 0;
        }
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr><td colspan='2'><i>Total de $i registros</i></td></tr>";
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "</tbody></table>";

        //valor total do período
        $total_lancamentos = DataHelper::getDoubleToReal($total_taxas + $total_fundo + $total_outros);
        $html .= "<table align='right'><tbody style='font-size: 14px'>
                  <tr><td style='text-align:center'>Total Taxas Manut:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_taxas)."</td></tr>
                  <tr><td style='text-align:center'>Total Fundo Reser:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_fundo)."</td></tr>
                  <tr><td style='text-align:center'>Total Outros Lanc:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_outros)."</td></tr>
                  <tr><td width='120px' style='font-weight: bold; text-align:center'>Total Lançamentos:</td><td style='text-align:center;font-weight: bold;'> R$ ".$total_lancamentos."</td></tr>
                  <tr><td style='text-align:center'>Total Jurídico:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_juridico)."</td></tr>
                  <tr><td style='text-align:center'>Total Custas:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_custas)."</td></tr>
                  <tr><td style='font-weight: bold; text-align:center'>Sub-total:</td><td style='text-align:center;font-weight: bold;'> R$ ".DataHelper::getDoubleToReal(($total_outros + $total_taxas + $total_fundo + $total_juridico + $total_custas))."</td></tr>
                  <tr><td style='text-align:center'>Total Juros:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_juros)."</td></tr>
                  <tr><td style='text-align:center'>Total Multa:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_multa)."</td></tr>
                  <tr><td style='text-align:center'>Total Descontos:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_descontos)."</td></tr>
                  <tr><td style='text-align:center'>Total Abatimento:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_abatimento)."</td></tr>
                  <tr><td style='text-align:center'>Total Correção:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal($total_correcao)."</td></tr>
                  <tr><td style='font-weight: bold; text-align:center'>Total a Receber:</td><td style='text-align:center;font-weight: bold;'> R$ ".DataHelper::getDoubleToReal($total_a_receber)."</td></tr>
                  <tr><td style='font-weight: bold; text-align:center'>Total Recebido:</td><td style='text-align:center;font-weight: bold;'> R$ ".DataHelper::getDoubleToReal($total_recebido)."</td></tr>
                  <tr><td style='text-align:center'>Diferença:</td><td style='text-align:center'> R$ ".DataHelper::getDoubleToReal(($total_recebido - $total_a_receber))."</td></tr>";
        $html .= "</tbody></table>";
        $footer = $this->pdf_footer('Relatório de Títulos Recebidos');

        //return response($html);
        $mpdf = new PrintPdf('', 'A4-L', 7, '', 5, 5, 10, 15, 1, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function acordosEfetuados(AcordosEfetuadosRequest $request)
    {
        set_time_limit(0);
        ini_set('memory_limit','1024M');
        $data = $request->all();
        $data_ini = DataHelper::setDate($data["data_inicial"]);
        $data_fim = DataHelper::setDate($data["data_final"]);
        $Data = Acordo::with(['recebimento_parcelas' => function($q){
            $q->with('parcelasBoleto');
        }])
            ->whereBetween('data_acordo',[$data_ini,$data_fim])
            ->where('status',1)
            ->get();
        $text_periodo = DataHelper::getPrettyDate($data_ini)." à ".DataHelper::getPrettyDate($data_fim);
        $html =  $this->pdf_cabecalho('Relatório de Acordos analítico',$text_periodo);
        $html .= "<style>.total_parcela td{ font-weight: bold; }</style>";
        $html .= "<table style=' width: 100%;'><tbody>";

//        return $Data[0]->parcelas_negociadas[10]->recebimento_parcela->recebimento->lancamentos[0]->lancamento;

        foreach ($Data as $acordo) {
            $html .= "<tr><td>&nbsp;</td></tr>
                        <tr style='background-color: #bbbbbb;'>
                        <th style='width: 20%'>Associado</th>
                        <th style='width: 3%'>Qd/Lt</th>
                        <th style='width: 8%'>Situação</th>
                        <th style='width: 7%'>Nosso Nº</th>
                        <th style='width: 6%;'>Data Venc</th>
                        <th style='width: 5%;text-align: right;'>Taxa<br>Manut.</th>
                        <th style='width: 6%;text-align: right;'>Fundo<br>Reserva</th>
                        <th style='width: 6%;text-align: right;'>Outros<br>Lanc.</th>
                        <th style='width: 4%;text-align: right;'>Multa</th>
                        <th style='width: 4%;text-align: right;'>Juros</th>
                        <th style='width: 5%;text-align: right;'>Correção</th>
                        <th style='width: 6%;text-align: right;'>Jurídico</th>
                        <th style='width: 6%;text-align: right;'>Custas<br>Proc.</th>
                        <th style='width: 6%;text-align: right;'>Descontos</th>
                        <th style='width: 6%;text-align: right;'>Entrada</th>
                        <th style='width: 6%;text-align: right;padding-right: 7px;'>Valor<br>Total</th>
                      </tr>";
            $valor_total_taxa = 0;
            $valor_total_fundo = 0;
            $soma_total_outros = 0;
            foreach ($acordo->parcelas_negociadas as $negociada) {
                //lancamentos de cada parcela
                $valor_taxa = 0;
                $valor_fundo = 0;
                $valor_desconto = 0;
                $valor_outros = 0;
                $num_parcelas = $negociada->recebimento_parcela->recebimento->numero_parcelas;

                //se for alguma parcela negociada que já foi de um outro acordo
                $check_acordo = Acordo::where('id_recebimento',$negociada->recebimento_parcela->id_recebimento)->first();

                $valor_entrada = ($check_acordo) ? ($check_acordo->valor_entrada / $num_parcelas) : 0;
                foreach ($negociada->recebimento_parcela->recebimento->lancamentos as $lancamentos){
                    switch ($lancamentos->lancamento->categoria){
                        case 1:
                            $valor_taxa = ($lancamentos->lancamento->valor / $num_parcelas);
                            break;
                        case 2:
                            $valor_fundo = ($lancamentos->lancamento->valor / $num_parcelas);
                            break;
                        case 7:
                        case 10:
                            $valor_desconto += ($lancamentos->lancamento->valor / $num_parcelas);
                            break;
                        default:
                            $valor_outros += (($lancamentos->lancamento->valor > 0 ? $lancamentos->lancamento->valor : 0) / $num_parcelas);
                    }
                }

                /*echo "<br>taxa: ".$valor_taxa;
                echo "<br>fundo: ".$valor_fundo;
                echo "<br>descconto: ".$valor_desconto;
                echo "<br>outros: ".$valor_outros;
                echo "<br>entrada: ".$valor_entrada;
                echo '<br><hr>';
                if ($negociada->id_parcela_negociada == 380) {
                    return '<br>FIM';
                }*/
                $valor_total_taxa += $valor_taxa;
                $valor_total_fundo += $valor_fundo;
                if($valor_outros > 0 ){
                    if ($valor_desconto > 0) {
                        $valor_outros = $valor_outros - $valor_desconto;
                    }
                    if ($valor_entrada > 0) {
                        $valor_outros = $valor_outros - $valor_entrada;
                    }
                    $soma_total_outros += $valor_outros;
                    $valor_total_outros = DataHelper::getDoubleToReal($soma_total_outros);
                } else {
                    $soma_total_outros = 0.00;
                    $valor_total_outros = '0,00';
                    $valor_outros = 0.00;
                }

                //quadra e lote
                $qdLt = Imovel::select('quadra','lote')->find($negociada->recebimento_parcela->recebimento->idimovel);
                $html .= "<tr>
                            <td style='text-align: left'>".$acordo->nome_parceiro."</td>
                            <td style='text-align: center'>".$qdLt->quadra."/".$qdLt->lote."</td>
                            <td style='text-align: center'>".($negociada->recebimento_parcela->situacaoInadimplencia ? $negociada->recebimento_parcela->situacaoInadimplencia->tipo_inadimplencia->descricao : '')."</td>
                            <td style='text-align: center'>".($negociada->recebimento_parcela->parcelasBoleto ? $negociada->recebimento_parcela->parcelasBoleto->nosso_numero : '')."</td>
                            <td style='text-align: center'>".($negociada->recebimento_parcela->parcelasBoleto ? $negociada->recebimento_parcela->parcelasBoleto->data_vencimento : '')."</td>
                            <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_taxa)."</td>
                            <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_fundo)."</td>
                            <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_outros)."</td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'></td>
                            <td style='text-align: right'>".DataHelper::getDoubleToReal($negociada->recebimento_parcela->valor)."</td>
                        </tr>";
            }
            $total_soma = (($valor_total_taxa + $valor_total_fundo) + $valor_total_outros);
            $html .= "<tr class='total_parcela' style='background-color: #EAEAEA;'>
                          <td colspan='5' style='text-align: center;'>TOTAL PARCELAS NEGOCIADAS</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_total_taxa)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_total_fundo)."</td>
                          <td style='text-align: right'>".$valor_total_outros."</td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'></td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($total_soma)."</td>
                    </tr>";
            /*$html .= "<tr style='background-color: #bbbbbb;'>
                        <th style=''>Associado</th>
                        <th style='width: 6%'>Quadra/Lote</th>
                        <th style='width: 4%'>Situação</th>
                        <th style='width: 6%'>Nosso Nº</th>
                        <th style='width: 6%'>Data Venc</th>
                        <th style='width: 6%;text-align: right;'>Taxa<br>Manut.</th>
                        <th style='width: 6%;text-align: right;'>Fundo<br>Reserva</th>
                        <th style='width: 6%;text-align: right;'>Outros<br>Lanc.</th>
                        <th style='width: 6%;text-align: right;'>Multa</th>
                        <th style='width: 6%;text-align: right;'>Juros</th>
                        <th style='width: 6%;text-align: right;'>Correção</th>
                        <th style='width: 6%;text-align: right;'>Jurídico</th>
                        <th style='width: 6%;text-align: right;'>Custas<br>Proc.</th>
                        <th style='width: 6%;text-align: right;'>Descontos</th>
                        <th style='width: 6%;text-align: right;'>Entrada</th>
                        <th style='width: 6%;text-align: right;padding-right: 3px;'>Valor Total</th>
                      </tr>";*/
            //valores de lancamentos de cada titulo gerado do acorodo está dividido pelo num de parcelas que foi dividido no acordo
            $valor_negociado_taxa = $valor_total_taxa / $acordo->recebimento_acordo->numero_parcelas;
            $valor_negociado_fundo = $valor_total_fundo / $acordo->recebimento_acordo->numero_parcelas;
            $valor_negociado_outros = 0;
            $valor_negociado_custas = 0;
            $valor_negociado_multa = 0;
            $valor_negociado_juros = 0;
            $valor_negociado_descontos = 0;
            $valor_negociado_juridico = 0;
            $valor_negociado_correcoes = 0;

            foreach ($acordo->recebimento_acordo->lancamentos as $lacamento_acordo) {
                switch ($lacamento_acordo->lancamento->categoria){
                    case 3:
                        $valor_negociado_outros += $lacamento_acordo->lancamento->valor;
                        break;
                    case 4:
                        $valor_negociado_custas += $lacamento_acordo->lancamento->valor;
                        break;
                    case 5:
                        $valor_negociado_multa += $lacamento_acordo->lancamento->valor;
                        break;
                    case 6:
                        $valor_negociado_juros += $lacamento_acordo->lancamento->valor;
                        break;
                    case 7:
                        $valor_negociado_descontos += $lacamento_acordo->lancamento->valor;
                        break;
                    case 8:
                        $valor_negociado_juridico += $lacamento_acordo->lancamento->valor;
                        break;
                    case 9:
                        $valor_negociado_correcoes += $lacamento_acordo->lancamento->valor;
                        break;
                }
            }
            $parcela_negociado_outros = $valor_negociado_outros / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_custas = $valor_negociado_custas / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_multas = $valor_negociado_multa / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_juros = $valor_negociado_juros / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_descontos = $valor_negociado_descontos / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_juridico = $valor_negociado_juridico / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_correcoes = $valor_negociado_correcoes / $acordo->recebimento_acordo->numero_parcelas;
            $parcela_negociado_entrada = $acordo->valor_entrada / $acordo->recebimento_acordo->numero_parcelas;


            $qdlt_acordo = Imovel::select('quadra','lote')->find($acordo->id_imovel);
            foreach ($acordo->recebimento_parcelas as $recebimento_parcela) {
                $html .= "<tr>
                        <td style='text-align: left'>".$acordo->nome_parceiro."</td>
                        <td style='text-align: center'>".$qdlt_acordo["quadra"]."/".$qdlt_acordo["lote"]."</td>
                        <td style='text-align: center'>Acordo ".$acordo->data_acordo."</td>
                        <td style='text-align: center'>".($recebimento_parcela->parcelasBoleto ? $recebimento_parcela->parcelasBoleto->nosso_numero : '')."</td>
                        <td style='text-align: center'>".($recebimento_parcela->parcelasBoleto ? $recebimento_parcela->parcelasBoleto->data_vencimento : '')."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_taxa)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_fundo)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_outros)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_multas)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_juros)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_correcoes)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_juridico)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($parcela_negociado_custas)."</td>
                        <td style='text-align: right'>-".DataHelper::getDoubleToReal($parcela_negociado_descontos)."</td>
                        <td style='text-align: right'>-".DataHelper::getDoubleToReal($parcela_negociado_entrada)."</td>
                        <td style='text-align: right'>".DataHelper::getDoubleToReal($recebimento_parcela->valor)."</td>
                    </tr>";
            }
            $html .= "<tr class='total_parcela' style='background-color: #EAEAEA;'>
                          <td colspan='5' style='text-align: center;'>TOTAL PARCELAS ACORDO</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_total_taxa)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_total_fundo)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_outros)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_multa)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_juros)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_correcoes)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_juridico)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($valor_negociado_custas)."</td>
                          <td style='text-align: right'>-".DataHelper::getDoubleToReal($valor_negociado_descontos)."</td>
                          <td style='text-align: right'>-".DataHelper::getDoubleToReal($acordo->valor_entrada)."</td>
                          <td style='text-align: right'>".DataHelper::getDoubleToReal($acordo->valor_acordo)."</td>
                      </tr>";
        }
        $footer = $this->pdf_footer('Relatório de Acordos Analítico');
        $html .= "</tbody></table>";
        //return response($html);
        $mpdf = new PrintPdf('', 'A4-L', 8, 'FreeSans', 5, 5, 10, 15, 1, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function acordosEfetuadosConsolidados(AcordosEfetuadosRequest $request){
        set_time_limit(0);
        ini_set('memory_limit','1024M');
        $data = $request->all();
        $data_ini = date_format(date_create($data["data_inicial"]), "d/m/y");
        $data_fim = date_format(date_create($data["data_final"]), "d/m/y");
        $Data = Acordo::with(['recebimento_parcelas' => function ($q) {
            $q->with('parcelasBoleto');
        }])
            ->where('status',2)
            ->whereBetween('data_acordo',[$data_ini,$data_fim])
            ->get();
        $text_periodo = $data_ini.' à '.$data_fim;
        $html = $this->pdf_cabecalho('Relatório de Acordos Consolidado',$text_periodo);
        $html .= "<style>tr th{ color: #FFFFFF}</style>";
        $html .= "<table style=' width: 100%;'><tbody>";
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr style='background-color: #717171;'>
                        <th style='width: 20%;text-align: left;'>Associado</th>
                        <th style='width: 5%'>Quadra/Lote</th>
                        <th style='width: 8%'>Situação</th>
                        <th style='width: 8%'>Nosso Nº</th>
                        <th style='width: 6%'>Data<br>Venc.</th>
                        <th style='width: 6%;'>Taxa<br>Manut.</th>
                        <th style='width: 5%;'>Fundo<br>Reserva</th>
                        <th style='width: 5%;'>Outros<br>Lanc.</th>
                        <th style='width: 5%;'>Multa</th>
                        <th style='width: 5%;'>Juros</th>
                        <th style='width: 6%;'>Valor<br>Total</th>
                        <th style='width: 6%;'>Dt.<br>Pgto</th>
                        <th style='width: 6%;'>Pgto</th>
                        <th style='width: *;padding-right: 7px;'>Saldo</th>
                      </tr>";
        $i=0;
        $total_acordo = 0;
        $total_pgto = 0;
        $total_saldo = 0;
        foreach ($Data as $acordo) {
            $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';
            //quadra e lote
            $qdLt = Imovel::select('quadra','lote')->find($acordo->id_imovel);
            foreach ($acordo->recebimento_parcelas as $recebimento_parcela) {
                $valor_pago = !is_null($recebimento_parcela->data_recebimento) ? $recebimento_parcela->valor:0;
                $valor_pago_format = $valor_pago == 0 ? '' : DataHelper::getDoubleToReal($valor_pago);
                $saldo = is_null($recebimento_parcela->data_recebimento) ? $recebimento_parcela->valor_origem : $recebimento_parcela->valor_origem - $recebimento_parcela->valor;
                $saldo_format = $saldo == 0 ? '' : DataHelper::getDoubleToReal($saldo);
                $html .= "<tr style='background-color: ".$c."'>
                            <td style='text-align: left'>" . $acordo->nome_parceiro . "</td>
                            <td style='text-align: center'>" . $qdLt->quadra . "/" . $qdLt->lote . "</td>
                            <td style='text-align: center'>Acordo " .$acordo->data_acordo. "</td>
                            <td style='text-align: center'>".($recebimento_parcela->parcelasBoleto ? $recebimento_parcela->parcelasBoleto->nosso_numero : '')."</td>
                            <td style='text-align: center'>".($recebimento_parcela->parcelasBoleto ? $recebimento_parcela->parcelasBoleto->data_vencimento : '')."</td>
                            <td style='text-align: center'>" . DataHelper::getDoubleToReal($recebimento_parcela->valor) . "</td>
                            <td style='text-align: center'>-</td>
                            <td style='text-align: center'>-</td>
                            <td style='text-align: center'>-</td>
                            <td style='text-align: center'>-</td>
                            <td style='text-align: right'>".DataHelper::getDoubleToReal($recebimento_parcela->valor_origem)."</td>
                            <td style='text-align: right'>".$recebimento_parcela->data_recebimento."</td>
                            <td style='text-align: center'>".$valor_pago_format."</td>
                            <td style='text-align: right;padding-right: 5px;'>".$saldo_format."</td>
                        </tr>";
                $total_acordo += $recebimento_parcela->valor_origem;
                $total_pgto += $valor_pago;
                $total_saldo += $saldo;
            }
            $i++;
        }
        $total_saldo = $total_saldo == 0 ? '' : DataHelper::getDoubleToReal($total_saldo);
        $total_pgto = $total_pgto == 0 ? '' : DataHelper::getDoubleToReal($total_pgto);
        $html .= "<tr style='background-color: #bbbbbb;'>
                        <td colspan='10' style='text-align: center;font-weight: bold;'>TOTAL ACORDO</td>
                        <td style='text-align: right;font-weight: bold;'>" .DataHelper::getDoubleToReal($total_acordo)."</td>
                        <td>&nbsp;</td>
                        <td style='text-align: center;font-weight: bold;'>".$total_pgto."</td>
                        <td style='text-align: right;padding-right: 5px;font-weight: bold;'>".$total_saldo."</td>
                    </tr>";
        $footer = $this->pdf_footer('Relatório de Acordos Consolidado');
        $html .= "</tbody></table>";
        //return response($html);
        $mpdf = new PrintPdf('', 'A4-L', 8, 'FreeSans', 5, 5, 10, 15, 1, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function previstoRealizado(RelatorioPrevistoRealizadoRequest $request){
        $data = $request->all();
        setlocale(LC_ALL, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
        $mes_extenso = utf8_encode(ucfirst(strftime('%B / %Y', mktime(0, 0, 0, $data["mes"], 1))));

        $result = Estimado::where('estimados.mes_competencia',$data["mes"])->where('estimados.ano_competencia',$data["ano"])
            ->with(['lancamento_pagar' => function($q) use($data) {
                $q->where('mes_competencia',$data["mes"]);
                $q->where('ano_competencia',$data["ano"]);
                $q->with(['parcelas' => function($q) use($data) {
                    $q->where('tipo_operacao','Débito');
                    $q->whereRaw('MONTH(data_pagamento) = '.$data["mes"].'');
                    $q->whereRaw('YEAR(data_pagamento) = '.$data["ano"].'');
                }]);
            }])
            ->join('tipo_lancamentos','tipo_lancamentos.id','estimados.id_tipolancamento')
            ->join('grupo_lancamentos','grupo_lancamentos.id','estimados.id_grupolancamento')
            ->select('estimados.*','tipo_lancamentos.id as id_tipo_lancamento','tipo_lancamentos.descricao as plano','grupo_lancamentos.id as id_grupo_lancamento','grupo_lancamentos.descricao as descricao_grupo')
            ->orderBy('grupo_lancamentos.id')
            ->get();

        if ($result->count() == 0){
            return response()->error('Não foi encontrado nenhum resultado!');
        }

        $html = $this->pdf_cabecalho('Relatório Previsto X Realizado',$mes_extenso);
        $html .= "<style>.sub-topico{ padding-left: 10px; }</style>";
        $footer = $this->pdf_footer('Relatório Previsto Realizado');
        $html .= "<table style='border-collapse: collapse; width: 100%;'><tbody>";
        //espaço depois do cabeçalho
        $html .= "<tr><td>  </td></tr>";
        $html .= "<tr><td>  </td></tr>";
        $html .= "<tr><td>  </td></tr>";

        $html .= "<tr style='background-color: #EAEAEA;'>
                        <th>Descrição</th>
                        <th style='width: 15%;text-align:right;'>Valor Previsto</th>
                        <th style='width: 10%;text-align:right;'>Valor Realizado</th>
                        <th style='width: 10%;text-align:right;'>Porcentagem</th>
                      </tr>";
        $i = 0;
        $grupoTopico = 0;
        $total_grupo = 0;
        $total_grupo_arr = [];
        $total_parcelas_pagas = 0;
        $total_parcelas_pagas_arr = [];
        $total_geral_previsto = 0;
        $total_geral_realizado = 0;
        //calculcando totais
        foreach ($result as $item) {
            if ($grupoTopico != $item->id_grupo_lancamento){
                $grupoTopico = $item->id_grupo_lancamento;
                $total_grupo = 0;
                $total_parcelas_pagas = 0;
            }
            $total_grupo += $item->valor;
            $total_grupo_arr[$item->id_grupo_lancamento] = $total_grupo;
            $total_geral_previsto += $item->valor;
            foreach ($item->lancamento_pagar as $lancamento) {
                foreach ($lancamento->parcelas as $parcela) {
                    $total_parcelas_pagas += $parcela->valor_pago;
                    $total_parcelas_pagas_arr[$item->id_grupo_lancamento] = $total_parcelas_pagas;
                    $total_geral_realizado += $parcela->valor_pago;
                }
            }
        }

        $grupoTopico = 0;
        foreach ($result as $item){
            $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';
            if ($grupoTopico != $item->id_grupo_lancamento){
                $valor_total_pago = isset($total_parcelas_pagas_arr[$item->id_grupo_lancamento]) ? $total_parcelas_pagas_arr[$item->id_grupo_lancamento] : 0;
                $percent_valor_total = ($valor_total_pago / $total_grupo_arr[$item->id_grupo_lancamento]) * 100;
                $color_percent = (round($percent_valor_total)>100)?'red':'black';
                $html .= "
                      <tr style='background-color: $c'>
                        <td style='text-align:left;font-weight: bold;'>".$item->descricao_grupo."</td>
                        <td style='text-align:right;font-weight: bold;'>".DataHelper::getDoubleToReal($total_grupo_arr[$item->id_grupo_lancamento])."</td>
                        <td style='text-align:right;width: 15%;'>".DataHelper::getDoubleToReal($valor_total_pago)."</td>
                        <td style='text-align:right;width: 13%;color:$color_percent;'>".round($percent_valor_total,1)."%</td>
                      </tr>";
                $grupoTopico = $item->id_grupo_lancamento;
            }
            if (!empty($item["lancamento_pagar"])) {
                $valor_parcelas_item = 0;
                foreach ($item->lancamento_pagar as $parcelas) {
                    foreach ($parcelas->parcelas as $parcela) {
                        $valor_parcelas_item += $parcela->valor_pago;
                    }
                }
            } else {
                $valor_parcelas_item = 0;
            }
            $percent_valor = ($valor_parcelas_item / $item->valor) * 100;
            $color_percent = (round($percent_valor)>100)?'red':'black';
            $html .= "
                  <tr style='background-color: $c;'>
                    <td style='padding-left:20px;text-align:left;'>".$item->plano."</td>
                    <td style='padding-left:20px;text-align:right;'>".DataHelper::getDoubleToReal($item->valor)."</td>
                    <td style='padding-left:20px;text-align:right;'>".DataHelper::getDoubleToReal($valor_parcelas_item)."</td>
                    <td style='padding-left:20px;text-align:right;color:$color_percent'>".round($percent_valor,1)."%</td>
                  </tr>";
            $i++;
        }
        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr><td colspan='2'><i>Total de $i registros</i></td></tr>";
        $html .= "<tr><td>&nbsp;</td></tr>";

        //valor total do período
        $html .= "<tr><td colspan='4' style='font-weight: bold; text-align:right'>Valor total Previsto: R$ ".DataHelper::getDoubleToReal($total_geral_previsto)."</td></tr>";
        $html .= "<tr><td colspan='4' style='font-weight: bold; text-align:right'>Valor total Realizado: R$ ".DataHelper::getDoubleToReal($total_geral_realizado)."</td></tr>";
        $html .= "</tbody></table>";

        //$teste = new \mPDF('','','','','','','','','','','');
        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 5, 15, 10, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
        //return response($html);
    }


    public function listaDePresencaAssembleia ($id)
    {
        set_time_limit(0);
        ini_set('memory_limit','1024M');

        $asembleia = Assembleia::find($id);

        if(!count($asembleia))
        {
            abort(404);
        }


        $listaPresenca = DB::select("
                select
                    p.nome,
                    p.cpf ,
                    concat('QD ', i.quadra,' / LT ',i.lote) as unidade,
                    concat('x', av.peso_voto) as peso,
                    av.created_at,
                    token as dispositivo
                from assembleia_votacoes av 
                inner join bioacesso_portaria.pessoa p on av.id_pessoa = p.id 
                inner join bioacesso_portaria.imovel i on i.id = av.imovel 
                where id_assembleia  = $asembleia->id
                group by imovel
        ");

        //$totalPessoa = count(AssembleiaVotacao::where('id_assembleia', $asembleia->id)->groupBy('id_pessoa')->get());
        $totalPessoa = DB::select("
            select count(id) as total 
            from (
                select
                 av.id 
                from assembleia_votacoes av 
                where av.id_assembleia  = $asembleia->id
                group by id_pessoa
            ) as sub"
        );

        $totalUnidades = DB::select("
            select count(id) as total 
            from (
                select
                 av.id 
                from assembleia_votacoes av 
                where av.id_assembleia  = $asembleia->id
                group by imovel
            ) as sub"
        );

        $totalVotos = DB::select("
            select sum(peso_voto) as total 
            from (
                select
                 peso_voto 
                from assembleia_votacoes av 
                where av.id_assembleia  = $asembleia->id
                group by imovel
            ) as sub"
        );

        $tituloassembleia = $asembleia->titulo . ' ' . $asembleia->data_fim . ' até as ' . $asembleia->hora_fim;

        $html = $this->pdf_cabecalho('LISTA DE PRESENÇA', $tituloassembleia);
        $footer = $this->pdf_footer('LISTA DE PRESENÇA');

        $html .= "<table style='border: 1px solid black; width: 100%; text-align: center; margin: 5% 10%;'>";
        $html .= "<tr >
                <td style='border: 1px solid black;'>" . $totalPessoa[0]->total ." pessoa(s) presente(s)</td>
                <td style='border: 1px solid black;'>" . $totalUnidades[0]->total ." unidade(s)</td>    
                <td style='border: 1px solid black;'>" . $totalVotos[0]->total ." votos totais
            (considerando o peso)</td>
   
                </tr>";
        $html .= "</table>";

        $html .= "<table style='border-collapse: collapse; width: 100%;'><tbody>";
        $html .= "<tr style='background-color: #EAEAEA;'>
                        <th style='width: 20%;text-align: left;'>Morador</th>
                        <th style='width: 10%'>CPF/CNPJ</th>
                        <th style='width: 10%'>Unidade</th>
                        <th style='width: 5%'>Peso</th>
                        <th style='width: 15%'>Data</th>
                        <th style='width: 10%;'>Dispositivo</th>
                      </tr>";

        $i = 0;

        foreach ($listaPresenca as $item)
        {
            $c = ($i%2 != 0)? '#EAEAEA' : '#FFF';

            $html .= "
                      <tr style='background-color: $c'>
                        <td>". $item->nome ."</td>
                        <td style='text-align:center'>". $item->cpf."</td>
                        <td style='text-align:center'>".$item->unidade."</td>
                        <td style='text-align:center'>".$item->peso."</td>
                        <td style='text-align:center;'>".DataHelper::getPrettyDateTime($item->created_at)."</td>
                        <td style='text-align:center'>".$item->dispositivo."</td>
                      </tr>";
             $i++;
        }

        $html .= "<tr><td>&nbsp;</td></tr>";
        $html .= "<tr><td colspan='2'><i>Total de $i registros</i></td></tr>";
        $html .= "<tr><td>&nbsp;</td></tr>";

        $html .= "</tbody></table>";
    //return response($html);
        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 5, 15, 10, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function resultadoVotacoesAssembleia ($id)
    {
        set_time_limit(0);
        ini_set('memory_limit','1024M');

        $assembleia = Assembleia::find($id);

        if(!count($assembleia))
        {
            abort(404);
        }

        $tituloassembleia = $assembleia->titulo . ' ' . $assembleia->data_fim . ' até as ' . $assembleia->hora_fim;

        $html = $this->pdf_cabecalho('RESULTADO DAS VOTAÇÕES', $tituloassembleia);
        $footer = $this->pdf_footer('RESULTADO DAS VOTAÇÕES');

        $pautas = $assembleia->pautas()
            ->join('assembleia_perguntas', 'assembleia_pautas.id_pergunta', '=', 'assembleia_perguntas.id')
            ->get();

        $i = 1;
        $total = count($pautas);

        foreach ($pautas as $pauta)
        {
            $html .= "
            <div id='pauta' style='border: 1px solid black; margin: 10px'>
           
                <p style='margin:10px'>PAUTA $i DE  $total</p>
                <p style='margin:20px'>".$pauta['pergunta']."</p>
                <table style='border: 1px solid black;border-collapse: collapse; width: 95%;margin: 2px 13px;'>
                  <thead>
                    <tr>
                      <th style='text-align: left;'>Alternativas</th>
                      <th>Votos (c/ Peso)</th>
                      <th>Porcentagem</th>
                    </tr>
                  </thead>
                  <tbody>";

            $totalVotosPauta = AssembleiaVotacao::where('id_pergunta', $pauta['id_pergunta'])->where('id_assembleia',$assembleia->id)->sum('peso_voto');

            $opcoes = AssembleiaOpcao::where('assembleia_opcoes.id_pergunta', $pauta['id_pergunta'])
                ->select('assembleia_opcoes.id','opcao')
                ->get();
            $somaVotosAlternativas = 0;

            foreach ($opcoes as $opcao)
            {

                $totalVotosOpcao = AssembleiaVotacao::where('id_opcao', $opcao['id'])->where('id_assembleia',$assembleia->id)->sum('peso_voto');

                $somaVotosAlternativas += $totalVotosOpcao;
                $descricao = $opcao['opcao'];
                $percentual = round((($totalVotosOpcao / $totalVotosPauta) * 100),2);

                $html .= "  
                    <tr>
                      <td>$descricao</td>
                      <td style='text-align: center;'>$totalVotosOpcao</td>
                      <td style='text-align: center;'>$percentual%</td>
                    </tr>";
            }


            $html .= " 
                  </tbody>
                  <tfoot>
                    <tr>
                      <td>Total</td>
                      <td style='text-align: center;'>$somaVotosAlternativas</td>
                      <td style='text-align: center;'>100%</td>
                    </tr>
                  </tfoot>
                </table>";


            foreach ($opcoes as $opcao)
            {
                $descricao = $opcao['opcao'];
                $idOpcao = $opcao['id'];

                $listaPessoa = DB::select("
                    select
                        concat('QD ', i.quadra,' / LT ',i.lote) as unidade,
                        concat('x', av.peso_voto) as peso,
                        av.created_at,
                        p.nome
                    from assembleia_votacoes av 
                    inner join bioacesso_portaria.pessoa p on av.id_pessoa = p.id 
                    inner join bioacesso_portaria.imovel i on i.id = av.imovel 
                    where id_opcao  = $idOpcao
"               );

                $html .= "
                <br>
                <br> 
                <p style='margin: 10px'>$descricao</p>
                <hr>
                <table style='margin: 10px'>";

                foreach ($listaPessoa as $pessoa)
                {
                    $html .= "
                       <tr>
                          <td style='padding: 3px 5px;'>$pessoa->unidade ($pessoa->peso)</td>
                          <td style='padding: 3px 5px;'>". DataHelper::getPrettyDateTime($pessoa->created_at). "</td>
                          <td style='padding: 3px 5px;'>$pessoa->nome</td>
                        </tr>";
                }

                $html .= "</table>";
            }

            $html .= "</div>";
        }

        //return response($html);
        $mpdf = new PrintPdf('', '', 8, '', 5, 5, 5, 15, 10, 8);
        $mpdf->SetHTMLFooter($footer);
        $mpdf->WriteHTML($html);

        return response($mpdf->Output());
    }

    public function bytes_to_mb($bytes, $decimal_places = 1 ){
        return number_format($bytes / 1048576, $decimal_places);
    }
}