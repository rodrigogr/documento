<?php

namespace App\Http\Controllers;

use App\Models\CartaCobranca;
use App\Helpers\DataHelper;
use App\Http\Requests\CartaCobrancaRequest;
use App\Models\Condominio;
use App\Models\ParcelaBoleto;
use App\Models\RegistroCobranca;
use Respect\Validation\Validator;
use App\Mail\CartaCobrancaMail;
use App\PrintPdf;

class CartaCobrancaController extends Controller
{
    private $name = 'Modelo da Carta de cobrança';

    public function index(){
        return response()->success(CartaCobranca::all());
    }

    public function store(CartaCobrancaRequest $request){
        $data = $request->all();
        try {
            $Data = CartaCobranca::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    public function show($id){
        $Data = CartaCobranca::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(CartaCobrancaRequest $request, $id){
        $Data = CartaCobranca::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = CartaCobranca::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function filtro_envio_carta(CartaCobrancaRequest $request){
        $data = $request->all();
        $query = null;

        if ($data["data_ini"] != ""){
            $diaini = DataHelper::setDate($data["data_ini"]);
            $diafim = DataHelper::setDate($data["data_fim"]);;
            $query = ParcelaBoleto::whereBetween('parcela_boletos.data_vencimento',[$diaini,$diafim]);
        } elseif ($data["mes"] != ""){
            $query = ParcelaBoleto::whereMonth('parcela_boletos.data_vencimento',$data["mes"])->whereYear('parcela_boletos.data_vencimento',$data["ano"]);
        } elseif ($data["id_imovel"] != ""){
            $query = ParcelaBoleto::where('r.idimovel',$data["id_imovel"]);
        } elseif ($data["id_empresa"] != "") {
            $query = ParcelaBoleto::where('r.id_empresa',$data["id_empresa"]);
        } else {
            $query = new ParcelaBoleto();
        }
        $result = $query->where('parcela_boletos.situacao','Provisionado')->where('parcela_boletos.data_vencimento','<',date('Y-m-d'))
            ->join('recebimento_parcelas as rp','parcela_boletos.id_parcela','rp.id')
            ->join('recebimentos as r','rp.id_recebimento','r.id')
            ->leftJoin('imovel_permanente as im', function ($q){
                $q->on('im.id_imovel','r.idimovel');
                $q->where('im.pessoa_titular',1);
            })
            ->leftJoin('imovel as i','im.id_imovel','i.id')
            ->leftJoin('pessoa as p','p.id','im.id_pessoa')
            ->leftJoin('pessoa_permanente as pp','p.id','pp.id_pessoa')
            ->leftJoin('empresa as e','e.id','r.id_empresa')
            ->select('parcela_boletos.data_vencimento','parcela_boletos.id_parcela as id_boleto','i.logradouro',
                \DB::raw("CASE WHEN r.id_empresa is null THEN p.nome 
                                    ELSE e.nome_fantasia END as nome_cli"),
                \DB::raw("CASE WHEN r.id_empresa is null THEN CONCAT('Qd-',i.quadra,' Lt-',i.lote)
                                    ELSE CONCAT(e.endereco,' ',e.cidade,' ',e.estado) END as endereco"),
                \DB::raw("CASE WHEN r.id_empresa is null THEN pp.email_alternativo
                                    ELSE e.email END as email"),
                'r.id_empresa','r.idimovel','rp.valor')
            ->get();

        return response()->success($result);
    }

    public function visualizarCarta(CartaCobrancaRequest $request){
        $data = $request->all();
        $modelo = CartaCobranca::find($data["id_modelo"]);
        $arrVars = ["@{NOME_PARCEIRO}","@{ENDERECO_PARCEIRO}","@{VENCIMENTO}","@{VALOR}"];
        $arrSubs = [$data["nome"],$data["logradouro"].' '.$data["endereco"],$data["vencimento"],DataHelper::getDoubleToReal($data["valor"])];
        $carta_modelo = str_replace($arrVars,$arrSubs,$modelo->conteudo);

        $html = "<h2 style='text-align: center'>$modelo->titulo</h2><br><br>";
        $html .= $carta_modelo;

        $mpdf = new PrintPdf('','A4',11,'DejaVuSansCondensed');
        $mpdf->WriteHTML($html,0);

        return $mpdf->Output();
    }

    /** @param CartaCobrancaRequest $request @return mixed */
    public function enviarCobranca(CartaCobrancaRequest $request){
        $data = $request->all();
        $modelo = CartaCobranca::find($data["id_modelo"]);
        $condominio = Condominio::all()->first();
        $i = 0;

        foreach ($data["selecionados"] as $item) {
            //monta a carta
            $arrVars = ["@{NOME_PARCEIRO}","@{ENDERECO_PARCEIRO}","@{VENCIMENTO}","@{VALOR}"];
            $arrSubs = [$item["nome"],$item["logradouro"].' '.$item["endereco"],$item["vencimento"],DataHelper::getDoubleToReal($item["valor"])];
            $carta_modelo = str_replace($arrVars,$arrSubs,$modelo->conteudo);

            $html = "<h2 style='text-align: center'>$modelo->titulo</h2><br><br>";
            $html .= $carta_modelo;
            $infor_email = [
                "conteudo_html" => $html,
                "condominio" => $condominio->nome_fantasia,
                "email_condominio" => $condominio->email
            ];
            $email_invalido = [];
            //gera o pdf da carta
            $mpdf = new PrintPdf('','A4',11,'DejaVuSansCondensed');
            $mpdf->WriteHTML($html,0);
            $pdf = $mpdf->output('','S');
            //envia o e-mail
            if ($item["email"]!= "") {
                $emails = explode( ';',$item["email"]);
                foreach ($emails as $email) {
                    if (Validator::email()->validate($email)) {
                        $sent = \Mail::to($email)->send(new CartaCobrancaMail($infor_email, $pdf));
                        if ($sent != "") {
                            $i++;
                            //grava o envio
                            $registro_envio = new RegistroCobranca();
                            $registro_envio->id_boleto = $item["id_boleto"];
                            $registro_envio->id_imovel = (empty($item["id_imovel"])) ? null : $item["id_imovel"];
                            $registro_envio->id_empresa = (empty($item["id_empresa"])) ? null : $item["id_empresa"];
                            $registro_envio->modelo = $data["id_modelo"];
                            $registro_envio->nome = $item["nome"];
                            $registro_envio->endereco = $item["endereco"];
                            $registro_envio->data_vencimento = DataHelper::setDate($item["vencimento"]);
                            $registro_envio->data_envio = date("Y-m-d");
                            $registro_envio->save();
                        }
                    } else {
                        $email_invalido[] = '<br>- '.$item["nome"] . ': ' . $email;
                    }
                }
            }
        }
        if (count($email_invalido) > 0) {
            $msg_retorno = 'A cobrança para esse(s) e-mail(s) não foram enviados:<br>';
            foreach ($email_invalido as $invalidos) {
                $msg_retorno .= $invalidos;
            }
            if ($i > 0) {
                $msg_retorno .= '<br><br><i style="color:green;font-size: 32px;" class="fa fa-check-circle-o"></i>&nbsp;Para as outras cobranças foram enviadas com sucesso!';
            }
            return response()->error($msg_retorno);
        }
        $msg_retorno = count($data["selecionados"]) > 1 ? 'count '.$i.'. Cobranças enviadas com sucesso!' : 'Cobrança enviada com sucesso!' ;
        return response()->success($msg_retorno);
    }

    public function filtro_registro_cobranca(CartaCobrancaRequest $request){
        $data = $request->all();
        if ($data["data_ini"] != ""){
            $diaini = DataHelper::setDate($data["data_ini"]);
            $diafim = DataHelper::setDate($data["data_fim"]);;
            $Data = RegistroCobranca::whereBetween('data_vencimento',[$diaini,$diafim]);
        } elseif ($data["mes"] != ""){
            $Data = RegistroCobranca::whereMonth('data_vencimento',$data["mes"])->whereYear('data_vencimento',$data["ano"]);
        } elseif ($data["id_imovel"] != ""){
            $Data = RegistroCobranca::where('id_imovel',$data["id_imovel"]);
        } elseif ($data["id_empresa"] != "") {
            $Data = RegistroCobranca::where('id_empresa',$data["id_empresa"]);
        } else {
            $todos = true;

        }
        if (isset($todos)){
            if ($data["modelo"] != "") {
                $result = RegistroCobranca::where('modelo',$data["modelo"])->get();
            } else {
                $result = RegistroCobranca::all();
            }
        } else {
            if ($data["modelo"] != ""){
                $result = $Data->where('modelo',$data["modelo"])->get();
            } else {
                $result = $Data->get();
            }
        }
        if(count($result)){
            return response()->success($result);
        } else {
            return response()->success('Nenhum registro encontrado!');
        }

    }
}