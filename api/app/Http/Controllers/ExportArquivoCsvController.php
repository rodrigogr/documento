<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Models\LancamentoAgendar;
use App\Models\ParcelaBoleto;
use App\Models\ParcelaPagar;
use App\Models\RecebimentoParcela;
use App\Services\BoletoServices;
use Illuminate\Http\Request;

class ExportArquivoCsvController extends Controller
{
    public function exportLancamentosLayoutTron(Request $request)
    {
        try {
            $boleto_service = new BoletoServices();
            set_time_limit(0);
            ini_set('memory_limit', '512M');
            $data = $request->all();
            $data = $data['data'];
            if ($data["tipo"] === 'csv') {
                $headers = [
                    'Cache-Control' => 'must-revalidate, post-check=0, pre-check=0',
                    'Content-type' => 'text/csv',
                    'Content-Disposition' => 'attachment; filename=lancamentos.csv',
                    'Expires' => '0',
                    'Pragma' => 'public'
                ];
            }

//            $list = ParcelaBoleto::join('recebimento_parcelas', 'parcela_boletos.id_parcela', 'recebimento_parcelas.id')
//                ->join('recebimentos', 'recebimento_parcelas.id_recebimento', 'recebimentos.id')
//                ->join('imovel', 'recebimentos.idimovel', 'imovel.id')
//                ->join('pessoa', 'recebimentos.idassociado', 'pessoa.id')
//                ->selectRaw("'25' as 'CODEMP',  DATE_FORMAT(parcela_boletos.data_vencimento,'%d-%m-%Y') as 'DTLAN',
//	parcela_boletos.nosso_numero as 'DOCLAN', 'C' as 'NATLAN' ,recebimento_parcelas.valor as 'VRLAN' ,
//    'CODNORCNT', 1 as 'CODIGOAGRUPADOR' ,  concat(pessoa.cpf,' ', pessoa.nome ,' ' , 'QD.:' ,imovel.quadra, '-','LT.:',imovel.lote) as 'COMPLEMENTO', id_parcela");
            $list = RecebimentoParcela::join('parcela_boletos', 'parcela_boletos.id_parcela', 'recebimento_parcelas.id')
                ->join('recebimentos', 'recebimento_parcelas.id_recebimento', 'recebimentos.id')
                ->join('imovel', 'recebimentos.idimovel', 'imovel.id')
                ->join('pessoa', 'recebimentos.idassociado', 'pessoa.id')
                ->selectRaw("'25' as 'CODEMP',  DATE_FORMAT(parcela_boletos.data_vencimento,'%d-%m-%Y') as 'DTLAN', 
	parcela_boletos.nosso_numero as 'DOCLAN', 'C' as 'NATLAN' ,recebimento_parcelas.valor as 'VRLAN' ,
    'CODNORCNT', 1 as 'CODIGOAGRUPADOR' ,  concat(pessoa.cpf,' ', pessoa.nome ,' ' , 'QD.:' ,imovel.quadra, '-','LT.:',imovel.lote) as 'COMPLEMENTO', id_parcela");
            if ($data["data_inicial"] != "") {
                $list = $list->whereBetween('parcela_boletos.data_vencimento', [DataHelper::setDate($data["data_inicial"]), DataHelper::setDate($data["data_final"])]);
            }
            if ($data["quadra"] != "") {
                $list = $list->where('imovel.quadra', $data["quadra"])->where('imovel.lote', $data["lote"]);
            }
            $list = $list->doesntHave('parcelasAcordo');
            $list = $list->get()->toArray();

            # add headers for each column in the CSV download
            array_unshift($list, array_keys($list[0]));

            $callback = function () use ($list, $data, $boleto_service) {
                $FH = fopen('php://output', 'w');
                $i = 0;
                foreach ($list as $row) {
                    if ($i == 0) {
                        unset($row[8]);
                        fputcsv($FH, $row, ";");
                    } else {
                        $boleto = $boleto_service->visualizar_boleto($row["id_parcela"], '', true);
                        $row["DOCLAN"] = $boleto->getNossoNumeroBoleto();
                        unset($row["id_parcela"]);
                        $row["CODEMP"] = $data["code_emp"];
                        $row["DTLAN"] = DataHelper::getPrettyDate($row["DTLAN"]);
                        $row["VRLAN"] = round($row["VRLAN"], 2);
                        $row["CODIGOAGRUPADOR"] = $data["codigo_agrupador"];
                        $row["CODNORCNT"] = $data["cod_nor_cont_credito"];
                        fputcsv($FH, $row, ";");
                        $row["NATLAN"] = 'D';
                        $row["CODNORCNT"] = $data["cod_nor_cont_debito"];
                        fputcsv($FH, $row, ";");
                    }
                    $i++;
                }
                fclose($FH);
            };

            return response()->stream($callback, 200, $headers);
        } catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error("Problemas ao gerar o arquivo!");
        }
    }
}
