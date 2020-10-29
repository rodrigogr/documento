<?php

namespace App\Http\Controllers;

use App\Helpers\DataHelper;
use App\Http\Requests\QuitacaoDocumentoRequest;
use App\Models\Empresa;
use App\Models\ImovelPermanente;
use App\Models\PessoaPermanente;
use Respect\Validation\Validator;
use App\Models\QuitacaoDocumento;
use Illuminate\Http\Request;
use App\PrintPdf;
use App\Mail\CartaQuitacaoMail;
use App\Models\Condominio;

class QuitacaoDocumentoController extends Controller
{
    private $name = "Declaração de quitação";


    public function index(){
        return response()->success(QuitacaoDocumento::all());
    }

    public function store(Request $request){
        $data = $request->all();
        try {
            $Data = QuitacaoDocumento::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage);
        }
        return response()->success(trans('messages.crud.FSS', ['name' => $this->name]));
    }

    public function show($id)
    {
        $Data = QuitacaoDocumento::find($id);
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function update(QuitacaoDocumentoRequest $request, $id)
    {
        $Data = QuitacaoDocumento::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
            return response()->error(trans('messages.crud.FGE', ['name' => $this->name]));
        }
    }

    public function destroy($id)
    {
        $Data = QuitacaoDocumento::find($id);
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

    public function filtro_emissao_declaracao(QuitacaoDocumentoRequest $request)
    {
        $data = $request->all();
				$result = [];
        if ($data["id_imovel"] != "") {
            $Data = ImovelPermanente::where('id_imovel', $data["id_imovel"])->where('pessoa_titular',1)->where('excluido','n')->first();
						if(empty($Data)) return response([]);
            array_push($result,  [
                'id_imovel' => $data["id_imovel"],
                'nome' => $Data->pessoa->nome,
                'endereco' => 'Qd '.$Data->imovel->quadra . ' Lt ' . $Data->imovel->lote,
                'id_empresa' => ""
						]);
        } elseif ($data["id_pessoa"] != "") {
            $Data = ImovelPermanente::where('id_pessoa',$data["id_pessoa"])->where('pessoa_titular',1)->where('excluido','n')->with('imovel','pessoa')->get();
						if(empty($Data)) return response([]);
            foreach ($Data as $item){
                array_push($result,  [
                    'id_imovel' => $item->id_imovel,
                    'nome' =>$item->pessoa->nome,
                    'endereco' => 'Qd '.$item->imovel->quadra.' Lt '.$item->imovel->lote,
                    'id_empresa' => ""
                ]);
            }
        } else {
            $Data = Empresa::find($data["id_empresa"]);
						if(empty($Data)) return response([]);
            array_push($result,  [
                'id_empresa' => $data["id_empresa"],
                'nome' => $Data->nome_fantasia,
                'endereco' => $Data->endereco.' '.$Data->cidade.'/'.$Data->estado,
                'id_imovel' => ""
            ]);
        }
        if(empty($result)) return response([]);
        else return response($result);
    }

    public function emissao_quitacao_visualizar(QuitacaoDocumentoRequest $request){
        $data = $request->all();
        $modelo_quitacao = QuitacaoDocumento::find($data["id_modelo"]);
        $arrVars = ["@{NOME_PARCEIRO}","@{IMOVEL_PARCEIRO}","@{PARCEIRO_RG}","@{PARCEIRO_CPF}","@{PARCEIRO_CNPJ}","@{ENDERECO_PARCEIRO}","@{PARCEIRO_RAZAO_SOCIAL}","@{DATA_FIM_ADIMPLENCIA}"];
        if ($data["id_empresa"] != ""){
            $empresa = Empresa::find($data["id_empresa"]);
            $arrSubs = ["","","","",$empresa->cnpj,$empresa->endereco.' '.$empresa->cidade.'/'.$empresa->estado,$empresa->razao_social,date("d/m/Y")];
            $declaracao = str_replace($arrVars,$arrSubs,$modelo_quitacao->conteudo);
        } else {
            $associado = ImovelPermanente::where('id_imovel',$data["id_imovel"])->first();
            $arrSubs = [$associado->pessoa->nome,'Qd-'.$associado->imovel->quadra." Lt-".$associado->imovel->lote,$associado->pessoa->rg,
                $associado->pessoa->cpf,"",$associado->imovel->logradouro,"",date("d/m/Y")];
            $declaracao = str_replace($arrVars,$arrSubs,$modelo_quitacao->conteudo);
        }
        $html = "<h2 style='text-align: center'>$modelo_quitacao->titulo</h2><br><br>";
        $html .= $declaracao;
        $mpdf = new PrintPdf('','A4',11,'DejaVuSansCondensed');
        $mpdf->WriteHTML($html,0);
        return $mpdf->Output();
    }

    public function enviarQuitacao(Request $request){
        try {
            $data = $request->all();
            $modelo_quitacao = QuitacaoDocumento::find($data["id_modelo"]);
            $condominio = Condominio::all()->first();
            foreach ($data["selecionados"] as $item) {
                //monta a carta
                $arrVars = ["@{NOME_PARCEIRO}","@{IMOVEL_PARCEIRO}","@{PARCEIRO_RG}","@{PARCEIRO_CPF}","@{PARCEIRO_CNPJ}","@{ENDERECO_PARCEIRO}","@{PARCEIRO_RAZAO_SOCIAL}","@{DATA_FIM_ADIMPLENCIA}"];
                if (isset($item["id_empresa"]) && $item["id_empresa"] != ""){
                    $empresa = Empresa::find($item["id_empresa"]);
                    // $item["email"] = 'email';
                    $arrSubs = ["","","","",$empresa->cnpj,$empresa->endereco.' '.$empresa->cidade.'/'.$empresa->estado,$empresa->razao_social,date("d/m/Y")];
                    $declaracao = str_replace($arrVars,$arrSubs,$modelo_quitacao->conteudo);
                } else {
                    $associado = ImovelPermanente::where('id_imovel',$item["id_imovel"])->first();
                    $pessoa_permanente = PessoaPermanente::where('id_pessoa', $associado->id_pessoa)->first();
                    $item["email"] = $pessoa_permanente->email ? $pessoa_permanente->email : $pessoa_permanente->email_alternativo;                    
                    $arrSubs = [$associado->pessoa->nome,'Qd-'.$associado->imovel->quadra." Lt-".$associado->imovel->lote,$associado->pessoa->rg,
                        $associado->pessoa->cpf,"",$associado->imovel->logradouro,"",date("d/m/Y")];
                    $declaracao = str_replace($arrVars,$arrSubs,$modelo_quitacao->conteudo);
                } 
                $html = "<h2 style='text-align: center'>$modelo_quitacao->titulo</h2><br><br>";
                $html .= $declaracao;
                $infor_email = [
                    "conteudo_html" => $html,
                    "condominio" => $condominio->nome_fantasia,
                    "email_condominio" => $condominio->email
                ];
                $mpdf = new PrintPdf('','A4',11,'DejaVuSansCondensed');
                $mpdf->WriteHTML($html,0);
                $pdf = $mpdf->output('','S');

                //envia o e-mail
                if ($item["email"]!= ""){
                    if (Validator::email()->validate($item["email"])) {
                        $sent = \Mail::to($item["email"])->send(new CartaQuitacaoMail($infor_email, $pdf));
                        if ($sent){
                            //grava o envio
                            $registro_envio = new QuitacaoDocumento();
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
                    }
                }
            }
            $msg_retorno = count($data["selecionados"]) > 1 ? 'Cartas de quitação enviadas com sucesso!' : 'Carta de quitação enviada com sucesso!' ;
            return response()->success($msg_retorno);
        } catch(Exception $e) {
            return response()->error($e);
        }
    }
}