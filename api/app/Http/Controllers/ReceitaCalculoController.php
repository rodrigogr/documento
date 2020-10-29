<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Helpers\DataHelper;
use App\Http\Requests\ReceitaCalculoRequest;
use App\Mail\BoletoMail;
use App\Models\Condominio;
use App\Models\ConfiguracaoCarteira;
use App\Models\ContasReceber;
use App\Models\LancamentosContaReceber;
use App\Models\LancamentosEstimados;
use App\Models\LancamentoTaxa;
use App\Models\ParcelaBoleto;
use App\Models\PessoaPermanente;
use App\Models\Recebimento;
use App\Models\Receita;
use App\Models\ReceitaCalculo;
use App\Models\SendEmail;
use App\PrintPdf;
use App\Services\BoletoServices;
use App\Services\FaturaService;
use App\Services\ReceitaCalculoServices;
use Carbon\Carbon;
use Eduardokum\LaravelBoleto\Boleto\Render\Pdf;
use Illuminate\Database\QueryException;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\App;
use League\Flysystem\Exception;
use Respect\Validation\Validator;
use Symfony\Component\Debug\Exception\FatalErrorException;

class ReceitaCalculoController extends  Controller {
    private $name = 'Taxa Associativa';

    public function index()
    {
        $Data = ReceitaCalculo::orderBy('data_vencimento','DESC')->paginate(6);
        return response($Data);
    }

    public function informacao($mes = null, $ano = null) {
        try {
            $receita = new ReceitaCalculoServices();
            return response()->success($receita->getInfoCalculo($mes,$ano));
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        } catch (QueryException $q){
            return response()->error($q->getMessage());
        } catch (FatalErrorException $f){
            return response()->error($f->getMessage());
        }
    }

    public function simulacao(ReceitaCalculoRequest $request) {
        try {
            $data = $request->all();
            $receita = new ReceitaCalculoServices();
            return response()->success($receita->simularCalculo($data));
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        } catch (QueryException $q){
            return response()->error($q->getMessage());
        }
    }

    public function aprovarSimulacao(ReceitaCalculoRequest $request){
        try {
            $data = $request->all();
            $receita = new ReceitaCalculoServices();
            return response()->success($receita->aprovarSimulacao($data));
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        } catch (QueryException $q){
            return response()->error($q->getMessage());
        } catch (FatalErrorException $f){
            return response()->error($f->getMessage());
        }
    }

    public function visualizarBoletos($id){
        set_time_limit(0);
        $lancamentos = LancamentoTaxa::where('id_receita_calculos','=',$id)->get();
        $boletos = [];
        $x = 0;
        foreach ($lancamentos as $lancamento) {
            $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                ->get();

            $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);
            $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);
            if(round($parcela_boleto->parcela->valor,2) > 0) {
                $boleto_service = new BoletoServices();
                $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

                $dem = [];
                $descricoes = "";
                /*foreach ($conta_receber->lancamentos as $lancamento_receber) {
                    if (EnumCategoriaLancamento::toString($lancamento_receber->categoria) == 'Descontos') {
                        $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$ -' . number_format($lancamento_receber->valor, 2, ',', '.');
                    } else {
                        $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$ ' . number_format($lancamento_receber->valor, 2, ',', '.');
                    }
                }*/
                $dem = array_add($dem, 0, $descricoes);
//                    $boleto = $boleto_service->gerarBoleto($parcela_boleto, $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
                $boleto = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela,'',true);

                $boletos = array_add($boletos, $x, $boleto);
            }
            $x++;
        }

        //Gerar em pdf
        $pdf = new \Eduardokum\LaravelBoleto\Boleto\Render\Pdf();
        $pdf->addBoletos($boletos,false);
        set_time_limit(30);
        return response($pdf->gerarBoleto(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; Boleto',
        ]);

    }

    public function emitirRemessa($id){
        try{
            set_time_limit(0);
            $receita_parametros = Receita::all('id_configuracao_carteira', 'percentualmulta','percentualjuros')->first()->get();
            if(!count($receita_parametros)){
                return 'Carteira não definida nas configurações de Receita.';
            }
            $carteira = ConfiguracaoCarteira::find($receita_parametros->first()->id_configuracao_carteira);
            if (!count($carteira)){
                return ('Carteira inválida!');
            }


            $boleto_service = new BoletoServices();
            $lancamentos = LancamentoTaxa::where('id_receita_calculos','=',$id)->get();
            $boletos = [];
            $x = 0;
            $codigo_banco = 0;
            foreach ($lancamentos as $lancamento) {
                $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                    ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                    ->get();

                $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);

                $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);
                if (round($parcela_boleto->parcela->valor,2) > 0) {
                    $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

                    $dem = [];
                    $descricoes = "";
                    foreach ($conta_receber->lancamentos as $lancamento_receber) {
                        if (EnumCategoriaLancamento::toString($lancamento_receber->categoria) == 'Descontos') {
                            $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$ -' . number_format($lancamento_receber->valor, 2, ',', '.');
                        } else {
                            $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$ ' . number_format($lancamento_receber->valor, 2, ',', '.');
                        }
                    }
                    $dem = array_add($dem, 0, $descricoes);
                    //                $boleto = $boleto_service->gerarBoleto($parcela_boleto, $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
                    $boleto = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela,'',true);

                    $parcela_boleto->nosso_numero_boleto = $boleto->getNossoNumeroBoleto();
                    $parcela_boleto->update();

                    $boletos = array_add($boletos, $x, $boleto);
                    $codigo_banco = $boleto->getCodigoBanco();
                }
                $x++;
            }
            $remessa = $boleto_service->gerarRemessa($carteira);
            // Adicionar um boleto.
            $remessa->addBoletos($boletos);
            $content = $remessa->gerar();

            if($codigo_banco==237) {
                $dsname = 'CB' . date( 'd', strtotime( $boleto->getDataDocumento())) . date( 'm', strtotime( $boleto->getDataDocumento())) . 'A'. strtoupper(str_random(1));
                $file_name = $dsname . '.rem';
            }elseif($codigo_banco == 756) {
                $content = mb_convert_encoding($content, 'Windows-1252');
                $file_name = strtoupper(str_random(7)). '.rem';
            } else {
                $file_name = strtoupper(str_random(7)) . '.rem';
            }

            \Storage::disk('local')->put('remessas/' . $file_name, $content);
            $file_path = storage_path('app/remessas/' .$file_name);
            set_time_limit(30);
            $headers = array('Content-Type' => 'text/plan', 'Content-Disposition' => 'attachment; filename="Teste.rem"');
            return response()->download($file_path, $file_name, $headers);
        }  catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error('Problemas ao fazer o download da remessa! ' . $e->getMessage());
        }

    }

    public function enviarEmail($id){
        try {
            set_time_limit(0);
            $lancamento_estimado = new LancamentosEstimadosController();
            $content = $lancamento_estimado->geraPdfEstimados(0);

            $condominio = Condominio::all('nome_fantasia','email');
            $lancamentos = LancamentoTaxa::where('id_receita_calculos', '=', $id)->get();
            $x = 0;
            foreach ($lancamentos as $lancamento) {
                $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                    ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                    ->get();
                //if ($lancamento_receber->first()->id_recebimento == 498) {
                $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);

                $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);
                if (round($parcela_boleto->parcela->valor,2) > 0) {
                    $boleto_service = new BoletoServices();

                    $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

                    $dem = [];
                    $i = 0;
                    $descricoes = "";
                    $resumo_email = [];

                    foreach ($conta_receber->lancamentos as $lancamento_receber) {
                        if (EnumCategoriaLancamento::toString($lancamento_receber->categoria) == 'Descontos') {
                            $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$ -' . number_format($lancamento_receber->valor, 2, ',', '.');
                            $resumo_email[$i] = ['descricao' => $lancamento_receber->descricao, 'valor R$ -' => number_format($lancamento_receber->valor, 2, ',', '.')];
                        } else {
                            $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - R$' . number_format($lancamento_receber->valor, 2, ',', '.');
                            $resumo_email[$i] = ['descricao' => $lancamento_receber->descricao, 'valor R$' => number_format($lancamento_receber->valor, 2, ',', '.')];
                        }
                        $i++;
                    }

//                    $dem = array_add($dem, 0, $descricoes);
//                    $boleto = $boleto_service->gerarBoleto($parcela_boleto, $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
//
//                    $pdf = new \Eduardokum\LaravelBoleto\Boleto\Render\Pdf();
//                    $pdf->addBoleto($boleto);
//                    $pdf->gerarBoleto(Pdf::OUTPUT_SAVE, storage_path('app/boletos/' . $id . '.pdf'));
//                    $pdf_path = storage_path('app/boletos/' . $id . '.pdf');
                    $boleto_pdf = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela,'S');

                    $pessoa_permanente = PessoaPermanente::where('id_pessoa', '=', $recebimento->idassociado)->get();

                    $emails = explode(";", $pessoa_permanente->first()->email_alternativo);

                    $infor_email = [
                        'lancamentos' => $resumo_email,
                        'titulo' => 'Boleto Mensal',
                        'vencimento' => $parcela_boleto->data_vencimento,
                        'associado' => $recebimento->associado->nome,
                        'nome_condominio' => $condominio->first()->nome_fantasia,
                        'email_condominio' => $condominio->first()->email,
                        'total' => DataHelper::getDoubleToReal($conta_receber->lancamentos->sum('valor'))
                    ];

                    if (!$parcela_boleto->email_enviado) {
                        if (\App::environment('production')) {
                            foreach ($emails as $email) {
                                if ($email) {
                                    if (Validator::email()->validate(trim($email))) {
                                        $sent = \Mail::to($email)->send(new BoletoMail($infor_email, $boleto_pdf, $content));
                                        if ($sent) {
                                            SendEmail::create([
                                                'id_pessoa' => $recebimento->associado->id,
                                                'email_enviado' => $email,
                                                'status' => 'Não Enviado'
                                            ]);
                                        } else {
                                            $parcela_boleto->email_enviado = true;
                                            $parcela_boleto->update();
                                            SendEmail::create([
                                                'id_pessoa' => $recebimento->associado->id,
                                                'email_enviado' => $email,
                                                'status' => 'Enviado'
                                            ]);
                                        }
                                    } else {
                                        SendEmail::create([
                                            'id_pessoa' => $recebimento->associado->id,
                                            'email_enviado' => $email,
                                            'status' => 'Não Enviado'
                                        ]);
                                    }
                                } else {
                                    SendEmail::create([
                                        'id_pessoa' => $recebimento->associado->id,
                                        'email_enviado' => $email,
                                        'status' => 'Não Enviado'
                                    ]);
                                }
                            }
                        } else {
                            $sent = \Mail::to('desenvolvimento@uzer.com.br')->send(new BoletoMail($infor_email, $boleto_pdf, $content));
                            if ($sent) {
                                SendEmail::create([
                                    'id_pessoa' => 1,
                                    'email_enviado' => 'desenvolvimento@uzer.com.br',
                                    'status' => 'Não Enviado'
                                ]);
                            } else {
                                SendEmail::create([
                                    'id_pessoa' => 1,
                                    'email_enviado' => 'desenvolvimento@uzer.com.br',
                                    'status' => 'Enviado'
                                ]);
                            }
                        }
                    }
                }
                $x++;
            }
            set_time_limit(30);
            return response()->success("Email enviado com sucesso!");
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function visualizarBoletosNaoEnviado($id){
        set_time_limit(0);
        $lancamentos = LancamentoTaxa::where('id_receita_calculos','=',$id)->get();
        $boletos = [];
        $x = 0;

        foreach ($lancamentos as $lancamento) {
            $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                ->get();

            $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);

            $parcela_boleto = ParcelaBoleto::where('id_parcela','=', $recebimento->parcelas->first()->id)->where('email_enviado','=',0)->get();
            if(count($parcela_boleto)) {

                $boleto_service = new BoletoServices();

                $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

                $dem = [];
                $i = 0;
                $descricoes = "";
                foreach ($conta_receber->lancamentos as $lancamento_receber) {
                    $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - ' . number_format($lancamento_receber->valor, 2, ',', '.');
                }
                $dem = array_add($dem, 0, $descricoes);
//                $boleto = $boleto_service->gerarBoleto($parcela_boleto->first(), $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
                $boleto = $boleto_service->visualizar_boleto($parcela_boleto->first()->id_parcela,'',true);
                $boletos = array_add($boletos, $x, $boleto);
            }

            $x++;
        }

        //Gerar em pdf
        $pdf = new \Eduardokum\LaravelBoleto\Boleto\Render\Pdf();
        $pdf->addBoletos($boletos, false);
        set_time_limit(30);
        return response($pdf->gerarBoleto(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; Boleto',
        ]);

        // Gerar em HTML
        //$html = new \Eduardokum\LaravelBoleto\Boleto\Render\Html();
        //$html->addBoletos($boletos);
        //$html->showPrint();

    }

    public function segunda_via_boletos($id){
        set_time_limit(0);
        $lancamentos = LancamentoTaxa::where('id_receita_calculos','=',$id)->get();
        $boletos = [];
        $x = 0;
        foreach ($lancamentos as $lancamento) {
            $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                ->get();
            //if($lancamento_receber->first()->id_recebimento == 698 || $lancamento_receber->first()->id_recebimento == 1024
            //|| $lancamento_receber->first()->id_recebimento == 878 || $lancamento_receber->first()->id_recebimento == 1230
            //|| $lancamento_receber->first()->id_recebimento == 1244 || $lancamento_receber->first()->id_recebimento == 1107){
            //if ($lancamento_receber->first()->id_recebimento == 994 || $lancamento_receber->first()->id_recebimento == 687
            //|| $lancamento_receber->first()->id_recebimento == 794 || $lancamento_receber->first()->id_recebimento == 890
            //|| $lancamento_receber->first()->id_recebimento == 1257 || $lancamento_receber->first()->id_recebimento == 895
            //|| $lancamento_receber->first()->id_recebimento == 698 || $lancamento_receber->first()->id_recebimento == 706
            //|| $lancamento_receber->first()->id_recebimento == 838 || $lancamento_receber->first()->id_recebimento == 1072
            //|| $lancamento_receber->first()->id_recebimento == 1117 || $lancamento_receber->first()->id_recebimento == 645
            //|| $lancamento_receber->first()->id_recebimento == 1024 || $lancamento_receber->first()->id_recebimento == 1260
            //|| $lancamento_receber->first()->id_recebimento == 1068 || $lancamento_receber->first()->id_recebimento == 1239
            //|| $lancamento_receber->first()->id_recebimento == 830
            //|| $lancamento_receber->first()->id_recebimento == 1077
            //) {

            $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);

            $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);
            $parcela_boleto->parcela->valor = $this->calcular_juros_multa($parcela_boleto);
            $parcela_boleto->data_vencimento = '2017-05-17';
            $boleto_service = new BoletoServices();

            $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

            $dem = [];
            $i = 0;
            $descricoes = "";
            foreach ($conta_receber->lancamentos as $lancamento_receber) {
                $descricoes = $descricoes . ' / ' . $lancamento_receber->descricao . ' - ' . number_format($lancamento_receber->valor, 2, ',', '.');
                //$dem = array_add($dem,$i,$descricao);
                //$i++;
            }

            //$dem = array_add($dem, 2, 'Boleto referente ao mês de Abril/2017');

            $dem = array_add($dem, 0, $descricoes);
//            $boleto = $boleto_service->gerarBoleto($parcela_boleto, $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
            $boleto = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela,'',true);

            $parcela_boleto->nosso_numero_boleto =  $boleto->getNossoNumeroBoleto();
            $parcela_boleto->update();

            $boletos = array_add($boletos, $x, $boleto);
            //}
            $x++;
        }

        //Gerar em pdf
        $pdf = new \Eduardokum\LaravelBoleto\Boleto\Render\Pdf();
        $pdf->addBoletos($boletos,false);
        set_time_limit(30);
        return response($pdf->gerarBoleto(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; Boleto',
        ]);

    }

    private  function calcular_juros_multa(ParcelaBoleto $boleto){
        $config_juros = 1;
        //$total_dias_mes = cal_days_in_month(CAL_GREGORIAN,date("m"),date("Y"));
        $calc_juros = (float)(($config_juros/30)/100);
        $calc_percent_juros = number_format($calc_juros,10);

        //$now = Carbon::now();
        $now = new \Carbon\Carbon("2017-05-16 14:28:40");

        $juros = 0;
        $total_juros = 0;
        $total_multa = 0;
        $total_parcial = 0;
        $total_original = 0;
        $total_original += $boleto->parcela->valor;
        $end = Carbon::parse($boleto->data_vencimento);
        $dias_atraso = $end->diffInDays($now);
        $valor = $boleto->parcela->valor;
        //juros compostos
        $M = $valor * pow((1 + $calc_percent_juros),$dias_atraso);
        $juros = $M - $valor;
        //totalizando o valor com juros e multas para cada boleto
        $calc_multa_percent = (float)2/100;
        $multa = $boleto->parcela->valor * $calc_multa_percent;
        $total_com_multa_e_juros = $boleto->parcela->valor + $multa + $juros;
        //somando valor de todos boletos
        $total_juros += $juros;
        $total_multa += $multa;
        $total_parcial += $total_com_multa_e_juros;


        return $total_parcial;
    }

    public function segunda_via_Remessa($id){
        set_time_limit(0);
        $receita_parametros = Receita::all('id_configuracao_carteira', 'percentualmulta','percentualjuros')->first()->get();
        if(!count($receita_parametros)){
            return 'Carteira não definida nas configurações de Receita.';
        }
        $carteira = ConfiguracaoCarteira::find($receita_parametros->first()->id_configuracao_carteira);
        if (!count($carteira)){
            return ('Carteira inválida!');
        }


        $boleto_service = new BoletoServices();
        $lancamentos = LancamentoTaxa::where('id_receita_calculos','=',$id)->get();
        $boletos = [];
        $x = 0;
        $codigo_banco = 0;
        foreach ($lancamentos as $lancamento) {
            $lancamento_receber = LancamentosContaReceber::join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $lancamento->id_lancamento)
                ->get();
            //if($lancamento_receber->first()->id_recebimento == 698 || $lancamento_receber->first()->id_recebimento == 1024
            //|| $lancamento_receber->first()->id_recebimento == 878 || $lancamento_receber->first()->id_recebimento == 1230
            //|| $lancamento_receber->first()->id_recebimento == 1244 || $lancamento_receber->first()->id_recebimento == 1107){
            //if ($lancamento_receber->first()->id_recebimento == 994 || $lancamento_receber->first()->id_recebimento == 687
            //|| $lancamento_receber->first()->id_recebimento == 794 || $lancamento_receber->first()->id_recebimento == 890
            //|| $lancamento_receber->first()->id_recebimento == 1257 || $lancamento_receber->first()->id_recebimento == 895
            //|| $lancamento_receber->first()->id_recebimento == 698 || $lancamento_receber->first()->id_recebimento == 706
            //|| $lancamento_receber->first()->id_recebimento == 838 || $lancamento_receber->first()->id_recebimento == 1072
            //|| $lancamento_receber->first()->id_recebimento == 1117 || $lancamento_receber->first()->id_recebimento == 645
            //|| $lancamento_receber->first()->id_recebimento == 1024 || $lancamento_receber->first()->id_recebimento == 1260
            //|| $lancamento_receber->first()->id_recebimento == 1068 || $lancamento_receber->first()->id_recebimento == 1239
            //|| $lancamento_receber->first()->id_recebimento == 830
            //|| $lancamento_receber->first()->id_recebimento == 1077
            //){
            $recebimento = Recebimento::complete($lancamento_receber->first()->id_recebimento);

            $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);
            $parcela_boleto->parcela->valor = $this->calcular_juros_multa($parcela_boleto);
            $parcela_boleto->data_vencimento = '2017-05-17';
            $conta_receber = ContasReceber::find($lancamento_receber->first()->id_conta_receber);

            $dem = [];
            $i = 0;
            foreach ($conta_receber->lancamentos as $lancamento_receber) {
                $descricao = $lancamento_receber->descricao . ' - ' . $lancamento_receber->valor;
                $dem = array_add($dem, $i, $descricao);
                $i++;
            }

            //$dem = array_add($dem, 2, '| Boleto referente ao mês de Abril/2017');

//            $boleto = $boleto_service->gerarBoleto($parcela_boleto, $recebimento->associado, $recebimento->imovel, $dem, $recebimento->carteira);
            $boleto = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela, '',true);

            $parcela_boleto->nosso_numero_boleto =  $boleto->getNossoNumeroBoleto();
            $parcela_boleto->update();

            $boletos = array_add($boletos, $x, $boleto);
            $codigo_banco = $boleto->getCodigoBanco();
            //}
            $x++;
        }

        $remessa = $boleto_service->gerarRemessa($carteira);
        // Adicionar um boleto.
        $remessa->addBoletos($boletos,false);
        $content = $remessa->gerar();

        if($codigo_banco==237) {
            $dsname = 'CB' . date( 'd', strtotime( $boleto->getDataDocumento())) . date( 'm', strtotime( $boleto->getDataDocumento())) . 'A'. strtoupper(str_random(1));
            $file_name = $dsname . '.rem';
        } else {
            $file_name = str_random(15) . '.rem';
        }

        \Storage::disk('local')->put('remessas/' . $file_name, $content);
        $file_path = storage_path('app/remessas/' .$file_name);
        $headers = array('Content-Type' => 'text/plan', 'Content-Disposition' => 'attachment; filename="Teste.rem"');
        set_time_limit(30);
        return response()->download($file_path, $file_name, $headers);

    }

    public function update_nosso_numero (){
        $parcela_boletos = ParcelaBoleto::all();
        $nosso_numero = 9400000;
        foreach ($parcela_boletos as $boleto){
            $parcela_boleto = ParcelaBoleto::find($boleto->id_parcela);
            $parcela_boleto->nosso_numero = $nosso_numero;
            $parcela_boleto->update();
            $nosso_numero ++;
        }

        return response("ok");
    }
}