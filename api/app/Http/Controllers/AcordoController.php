<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Http\Requests\AcordoRequest;
use App\Models\Acordo;
use App\Models\AcordoParcelasNegociadas;
use App\Models\Imovel;
use App\Models\ParcelaBoleto;
use App\Models\RecebimentoParcela;
use App\PrintPdf;
use App\Services\BoletoServices;
use App\Models\Condominio;
use App\Mail\BoletoMail;
use App\Services\FaturaService;
use Respect\Validation\Validator;
use App\Models\SendEmail;
use Eduardokum\LaravelBoleto\Boleto\Render\Pdf;
use Illuminate\Http\Request;


class AcordoController extends Controller
{
    private $name = 'Acordo';

    public function index(){
        $Data = Acordo::all();
        return response()->success($Data);
    }

    public function show($id){
        $Data = Acordo::with(['recebimento_parcelas' => function($q){
                $q->with('parcelasBoleto');
            }])
            ->with(['parcelas_negociadas' => function($q){
                $q->with('recebimento_parcela');
                $q->with('parcela_boleto');
            }])
            ->with(['recebimento_acordo' => function($q){
                $q->with(['lancamentos' => function($q){
                    $q->with('lancamento');
                }]);
            }])
            ->where('id',$id)
            ->get();
        if(count($Data) > 0){
            return response()->success($Data);
        } else {
            return response()->error('Acordo não encontrado.');
        }
    }

    public function filtro(Request $request){
        if($request['type'] == 'agendamento'){
            $data = Acordo::whereBetween('data_agendamento',[DataHelper::setDate($request['inicio']),DataHelper::setDate($request['fim'])])->get();
            return response($data);
        } elseif($request['type'] == 'logradouro'){
            $imovel = Imovel::select('id')->where(\DB::raw('ABS(quadra)'),$request['quadra'])->where(\DB::raw('ABS(lote)'),$request['lote'])->first();
            if(!$imovel) return response()->error('imóvel não encontrado');
            $data = Acordo::where('id_imovel',$imovel->id)->get();
            return response($data);
        }
    }

    public function cancelarAcordo(AcordoRequest $request){
        $Data = Acordo::find($request["id"]);
        if (count($Data)) {
            switch ($Data->status) {
                case "0":
                    return response()->error('Erro! Este acordo já está cancelado.');
                    break;
                case "2":
                    return response()->error('Erro ao cancelar! Este acordo já foi compensado.');
                    break;
                case "1":
                    $parcelas_acordo = \DB::table('acordos as a')
                        ->join('recebimento_parcelas as rp','rp.id_recebimento','=','a.id_recebimento')
                        ->join('parcela_boletos as pb','pb.id_parcela','=','rp.id')
                        ->where('a.id','=',$request["id"])
                        ->select('a.id_recebimento','rp.id as id_parcela','rp.valor as valor_parcela', 'pb.situacao')
                        ->get();
                    $valor_resgatado = 0;
                    $parcelas_compensadas = 0;
                    $boletos_abertos = [];
                    foreach ($parcelas_acordo as $item){
                        $ids_parcela_acordo[] = $item->id_parcela;
                        if($item->situacao == 'Compensado'){
                            $valor_resgatado += $item->valor_parcela;
                            $parcelas_compensadas++;
                        } else {
                            $boletos_abertos[] = $item->id_parcela;
                        }
                    }
                    //checando se todas parcelas já foram compensadas e por algum motivo o acordo não foi concluído
                    if(count($parcelas_acordo) == $parcelas_compensadas){
                        return response()->error('Erro ao cancelar! As parcelas desse acordo já foram compensadas.');
                        break;
                    }
                    try {
                        \DB::beginTransaction();
                        //todas parcelas negociadas voltam a ser provisionadas
                        $parcelas_negociados = AcordoParcelasNegociadas::where('id_acordo', $request["id"])->get();
                        foreach ($parcelas_negociados as $item) {
                            ParcelaBoleto::where('id_parcela', $item->id_parcela_negociada)->update(['situacao' => 'Provisionado']);
                        }
                        //abate o valor nas parcelas negociadas, se tiver parcela já paga
                        if ($parcelas_compensadas > 0) {
                            $valor_compensar = $valor_resgatado / count($parcelas_negociados);
                            //atualiza o valor das parcelas negociadas e o status volta para provisionado
                            foreach ($parcelas_negociados as $item) {
                                $novo_valor = $item->valor - $valor_compensar;
                                RecebimentoParcela::where('id', $item->id_parcela)->update(['valor' => $novo_valor]);
                            }
                            //altera o status das parcelas geradas que não foram pagas no acordo
                            foreach ($boletos_abertos as $item) {
                                ParcelaBoleto::find($item)->update(['situacao' => 'Cancelado']);
                            }
                        } else {
                            //altera o status das parcelas geradas no acordo
                            ParcelaBoleto::whereIn('id_parcela', $ids_parcela_acordo)->update(['situacao' => 'Cancelado']);
                        }

                        $cancelamento_txt = 'Cancelado em ' . date("d/m/Y") . '. ' . $request["descricao"];
                        Acordo::where('id', $request["id"])->update(['cancelamento' => $cancelamento_txt, 'status' => 0]);

                        \DB::commit();
                    } catch (Exception $e) {
                        \DB::rollBack();
                        return response()->error($e->getMessage());
                    } catch (QueryException $q ) {
                        \DB::rollBack();
                        return response()->error('Problema ao cancelar registro!<>'.$q->getMessage());
                    }
                    return response()->success(trans('messages.crud.MCS',['name' => $this->name]));
                break;
            }
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
        //fake true
        return true;
    }

    public function visualizar_boleto($id){
        $boleto_service = new BoletoServices();
        return $boleto_service->visualizar_boleto($id,'I');
    }

    public function download_remessa($id){
        try {
            $boleto_service = new BoletoServices();
            $remessa = $boleto_service->download_remessa($id);
            $headers = array('Content-Type' => 'text/plan', 'Content-Disposition' => 'attachment; filename="Boleto'.$id.'.rem"');
            return response()->download($remessa["file_path"], $remessa["file_name"], $headers);
        }  catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error('Problemas ao fazer o download da remessa! ' . $e->getMessage());
        }
    }

    public function enviar_email($id){
        $condominio = Condominio::first();
        $parcela_boleto = ParcelaBoleto::find($id);
        $arr_lancamentos = $parcela_boleto->parcela->recebimento->lancamentos->first()->conta_receber->lancamentos;
        $lancamentos = [];
        $i=0;
        foreach ($arr_lancamentos as $lancamento) {
            $lancamentos[$i] = ['descricao'=>$lancamento->descricao, 'valor'=>DataHelper::getDoubleToReal($lancamento->valor)];
            $i++;
        }

        $emails = explode(";", $parcela_boleto->parcela->recebimento->associado->morador->email_alternativo);
        $infor_email = [
            'lancamentos'=> $lancamentos,
            'titulo'=>'Boleto Negociação '.$condominio->nome_fantasia,
            'vencimento'=>$parcela_boleto->data_vencimento,
            'associado'=>$parcela_boleto->parcela->recebimento->associado->nome,
            'nome_condominio'=> $condominio->nome_fantasia,
            'email_condominio'=> $condominio->email,
            'total'=>DataHelper::getDoubleToReal($parcela_boleto->parcela->valor)
        ];
        $boleto_service = new BoletoServices();
        $boleto_pdf = $boleto_service->visualizar_boleto($id,'S');

        $id_pessoa = $parcela_boleto->parcela->recebimento->associado->morador->id_pessoa;
        $sent = null;

        if(\App::environment('production')) {
            foreach ($emails as $email) {
                if ($email) {
                    if (Validator::email()->validate($email)) {
                        $sent = \Mail::to($email)->send(new BoletoMail($infor_email, $boleto_pdf));
                        if ($sent) {
                            SendEmail::create([
                                'id_pessoa' => $id_pessoa,
                                'email_enviado' => $email,
                                'status' => 'Não Enviado'
                            ]);
                        } else {
                            SendEmail::create([
                                'id_pessoa' => $id_pessoa,
                                'email_enviado' => $email,
                                'status' => 'Enviado'
                            ]);
                        }
                    } else {
                        SendEmail::create([
                            'id_pessoa' => $id_pessoa,
                            'email_enviado' => $email,
                            'status' => 'Não Enviado'
                        ]);
                    }
                } else {
                    SendEmail::create([
                        'id_pessoa' => $id_pessoa,
                        'email_enviado' => $email,
                        'status' => 'Não Enviado'
                    ]);
                }
            }
        } else {
            $sent = \Mail::to('desenvolvimento@uzer.com.br')->send(new BoletoMail($infor_email, $boleto_pdf));
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
        return response()->success("Email enviado!");
    }
}
