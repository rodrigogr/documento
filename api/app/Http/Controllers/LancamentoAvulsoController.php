<?php

namespace App\Http\Controllers;

use App\EnumCategoriaLancamento;
use App\Helpers\DataHelper;
use App\Http\Requests\LancamentoAntigoRequest;
use App\Http\Requests\LancamentoAvulsoRequest;
use App\Mail\BoletoMail;
use App\Models\Condominio;
use App\Models\ConfiguracaoCarteira;
use App\Models\ContasReceber;
use App\Models\Empresa;
use App\Models\FluxoCaixa;
use App\Models\Imovel;
use App\Models\ImovelPermanente;
use App\Models\Lancamento;
use App\Models\LancamentoAntigo;
use App\Models\LancamentoAntigoLancamento;
use App\Models\LancamentoAvulso;
use App\Models\LancamentosContaReceber;
use App\Models\ParcelaBoleto;
use App\Models\Pessoa;
use App\Models\PessoaPermanente;
use App\Models\Recebimento;
use App\Models\RecebimentoParcela;
use App\Models\Receita;
use App\Models\SendEmail;
use App\PrintPdf;
use App\Services\BoletoServices;
//use Illuminate\Contracts\Routing\ResponseFactory;
use App\Services\FaturaService;
use App\Services\FluxoCaixaServices;
use Eduardokum\LaravelBoleto\Boleto\Render\Pdf;
use Illuminate\Database\QueryException;
use Illuminate\Mail\Message;
use Illuminate\Routing\ResponseFactory;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use League\Flysystem\Exception;
use Respect\Validation\Validator;
use Symfony\Component\Debug\Exception\FatalErrorException;
use Symfony\Component\VarDumper\Cloner\Data;
use Illuminate\Http\Request;
use Carbon\Carbon;

class LancamentoAvulsoController extends Controller
{
    private $name = 'Lançamento Avulso';

    public function index(Request $request){
        $req = $request->input();
        $Data = LancamentoAvulso::with(['carteira','layout_remessa','imovel','empresa','carteira'])
                ->with(['lancamento' => function($q) {
                    $q->join('lancamentos_contas_receber as lcr','lcr.id_lancamento','lancamentos.id');
                    $q->join('recebimento_lancamentos as rl','rl.id_lancamento_receber','lcr.id');
                    $q->join('recebimento_parcelas as rp','rp.id_recebimento','rl.id_recebimento');
                    $q->join('parcela_boletos as p','p.id_parcela','rp.id');
                    $q->select('lancamentos.*','p.situacao','p.id_parcela','p.nosso_numero');
                }]);
        if(isset($req['data_inicio']) && isset($req['data_fim'])){
            $Data = $Data->whereBetween('data_vencimento',[
                        DataHelper::setDate($req['data_inicio']),
                        DataHelper::setDate($req['data_fim'])
                    ]);
        }
        $Data = $Data->orderBy('id_lancamento','desc');
        $Data = $Data->paginate(11);
        foreach ($Data->Items() as $item) {
            if (!is_null($item->idimovel)) {
                //$morador = ImovelPermanente::where('id_imovel', '=', $item->idimovel)->where('pessoa_titular', '=', 1)->get();
                $morador = ImovelPermanente::getTitularImovel($item->idimovel);
                $item['nome_morador'] = $morador->first()->pessoa->nome;
            }
            if (!is_null($item->id_empresa)) {
                $empresa = Empresa::where('i
                d', '=', $item->id_empresa)->get();
                $item['nome_morador'] = $empresa->first()->nome_fantasia;
            }
        }
        return response($Data);
    }

    public function store(LancamentoAvulsoRequest $request){
        try {
            $data = $request->all();
            if (!empty($data['id_empresa'])) {
                unset($data["idimovel"]);
            } else {
                unset($data["id_empresa"]);
            }
            if (isset($data['idimovel'])) {
                $associado = ImovelPermanente::getTitularImovel($data['idimovel']);
                if (!count($associado)) {
                    return response()->error('Imovel não encontrado');
                }
            }
            $config_receita = Receita::all('percentualmulta', 'percentualjuros','id_tipoinadimplenciapadrao')->first()->get();
            if (!count($config_receita)) {
                return response()->error('Necessário definir os parâmetros em Confiugrações->Receitas.');
            }
            $carteira = ConfiguracaoCarteira::find($data['id_configuracao_carteira']);
            if (!count($carteira)) {
                return response()->error('Carteira inválida!');
            }
            if (!$carteira->nosso_numero_inicio) {
                return response()->error('Nosso número não defindo na configuração da carteira!');
            }
            if ($data["tipo_cobranca"] == 'nova') {
                \DB::beginTransaction();
                $data = array_add($data, 'saldo_receber', 0);
                $data = array_add($data, 'categoria', EnumCategoriaLancamento::toOrdinal('Outros'));
                $lancamento = Lancamento::create($data);
                $data = array_add($data, 'id_lancamento', $lancamento->id);
                $Data = LancamentoAvulso::create($data);
                $conta_receber = new  ContasReceber();
                $conta_receber->valor_total = $request['valor'];
                $conta_receber->total_provisionado = $request['valor'];
                $conta_receber->data_agendamento = $request['data_vencimento'];
                if (isset($data['idimovel'])) {
                    $conta_receber->id_imovel = $request['idimovel'];
                } else {
                    $conta_receber->id_empresa = $request['id_empresa'];
                }
                $conta_receber->save();
                $conta_receber->lancamentos()->attach($lancamento->id);
                $recebimento = new Recebimento();
                $recebimento->id_configuracao_carteira = $Data['id_configuracao_carteira'];
                $recebimento->id_layout_remessa = $Data['id_layout_remessa'];
                if (isset($data['idimovel'])) {
                    $recebimento->idimovel = $Data['idimovel'];
                    $recebimento->idassociado = $associado->first()->id_pessoa;
                } else {
                    $recebimento->id_empresa = $data["id_empresa"];
                }
                $recebimento->data_agendamento = $request['data_vencimento'];
                $recebimento->numero_parcelas = 1;
                $recebimento->save();
                foreach ($conta_receber->lancamentos as $lancamento) {
                    $recebimento->lancamentos()->attach($lancamento->pivot->id);
                }
                $recebimento_parcela = new RecebimentoParcela();
                $recebimento_parcela->forma_pagamento = 'TITULO';
                $recebimento_parcela->valor = $conta_receber->valor_total;
                $recebimento_parcela->valor_origem = $conta_receber->valor_total;
                $recebimento_parcela->id_recebimento = $recebimento->id;
                $recebimento_parcela->id_situacao_inadimplencia = $config_receita->first()->id_tipoinadimplenciapadrao;
                $recebimento_parcela->save();
                $titulo = new ParcelaBoleto();
                $titulo->id_parcela = $recebimento_parcela->id;
                $titulo->data_vencimento = $request['data_vencimento'];
                $titulo->data_vencimento_origem = $request['data_vencimento'];
                $titulo->percentualmulta = $config_receita->first()->percentualmulta;
                $titulo->percentualjuros = $config_receita->first()->percentualjuros;
                $titulo->juros_apos = 1;
                $titulo->dias_protesto = false;
                $titulo->nosso_numero = $carteira->nosso_numero_inicio;
                $titulo->nosso_numero_origem = $carteira->nosso_numero_inicio;
                $titulo->numero_documento = $lancamento->id;
                $titulo->situacao = 'Provisionado';
                $titulo->agrupado = 0;
                $titulo->aceite = 0;
                $titulo->especie_doc = 'DM';
                $titulo->save();
                $carteira->nosso_numero_inicio = $carteira->nosso_numero_inicio + 1;
                $carteira->update();
            } else { 
                //inicia a inclusão de dados dos lançamentos antigos
                //busca se já tem cadastrado boleto com o mesmo nosso numero
                $checkNossoNum = ParcelaBoleto::where('nosso_numero',$data["nosso_numero"])->whereNull('deleted_at');
                $numCheck = $checkNossoNum->count();
                if ($numCheck>0){
                    return response()->error('Lançamento não pode ser cadastrado, já existe um boleto com esse "Nosso Número"');
                }
                $data['id_empresa'] = NULL;
                //$data["data_vencimento"] = DataHelper::setDate($data["data_vencimento"]);
                $associado = ImovelPermanente::getTitularImovel($data['idimovel']);
                if (!count($associado)) {
                    return response()->error('Imovel não encontrado');
                }
                \DB::beginTransaction();
                $data = array_add($data,"tipo_cobranca","antiga");
                $lancamento_antigo = LancamentoAntigo::create($data);
                $rel_antigo["id_lancamento_antigo"] = $lancamento_antigo->id;
                $conta_receber = new  ContasReceber();
                $conta_receber->valor_total = $data['valor'];
                $conta_receber->total_provisionado = $data['valor'];
                $conta_receber->data_agendamento = $data['data_competencia'];
                $conta_receber->id_imovel = $data['idimovel'];
                $conta_receber->save();
                foreach ($data["lancamentos"] as $item){
                    $lancamento = new Lancamento();
                    $lancamento->valor = $item["valor"];
                    $lancamento->saldo_receber = 0;
                    $lancamento->idtipo_lancamento = $item["idtipo_lancamento"];
                    $lancamento->descricao = $item["descricao"];
                    $lancamento->categoria = EnumCategoriaLancamento::toOrdinal($item["categoria"]);
                    $lancamento->save();
                    $rel_antigo["id_lancamento"] = $lancamento->id;
                    LancamentoAntigoLancamento::create($rel_antigo);
                    $conta_receber->lancamentos()->attach($lancamento->id);
                    unset($lancamento);
                }
                $recebimento = new Recebimento();
                $recebimento->id_configuracao_carteira = $data['id_configuracao_carteira'];
                $recebimento->id_layout_remessa = $data['id_layout_remessa'];
                $recebimento->idimovel = $data['idimovel'];
                $recebimento->idassociado = $associado->first()->id_pessoa;
                $recebimento->data_agendamento = $data['data_vencimento'];
                $recebimento->numero_parcelas = 1;
                $recebimento->save();
                foreach ($conta_receber->lancamentos as $lancamento) {
                    $recebimento->lancamentos()->attach($lancamento->pivot->id);
                }
                $recebimento_parcela = new RecebimentoParcela();
                $recebimento_parcela->forma_pagamento = 'TITULO';
                $recebimento_parcela->valor = $conta_receber->valor_total;
                $recebimento_parcela->valor_origem = $conta_receber->valor_total;
                $recebimento_parcela->id_recebimento = $recebimento->id;
                $recebimento_parcela->id_situacao_inadimplencia = $data['id_situacao_inadimplencia'];
                $recebimento_parcela->save();
                $titulo = new ParcelaBoleto();
                $titulo->id_parcela = $recebimento_parcela->id;
                $titulo->data_vencimento = $data['data_vencimento'];
                $titulo->data_vencimento_origem = $data['data_vencimento'];
                $titulo->percentualmulta = $data["percentual_multa"]?$data["percentual_multa"]:0;//2.8
                $titulo->percentualjuros = $data["percentual_juros"]?$data["percentual_juros"]:0;//1.14
                $titulo->juros_apos = 1;
                $titulo->dias_protesto = false;
                $titulo->nosso_numero = $data["nosso_numero"];
                $titulo->nosso_numero_origem = $data["nosso_numero"];
                $titulo->numero_documento = $data["numero_documento"];
                $titulo->situacao = "Provisionado";
                $titulo->agrupado = 0;
                $titulo->aceite = $data["aceite"];//0(zero)
                $titulo->especie_doc = $data["especie_doc"];//'DM'
                $titulo->save();
            }
            //Cria fluxo da conta a receber
            $nome_associado = Pessoa::select('nome')->find($associado->first()->id_pessoa);
            $fluxo = [
                'id_conta_bancaria' => $carteira->id_conta_bancaria,
                'id_parcela' => $recebimento_parcela->id,
                'valor' => $conta_receber->valor_total,
                'data_vencimento' => $data['data_vencimento'],
                'data_pagamento' => null,
                'fluxo' => 'RECEITA',
                'tabela' => 'recebimento_parcela',
                'referente' => $nome_associado->nome,
                'descricao' => 'Boleto '.$titulo->nosso_numero.' - '.$data["descricao"].' Lançamento Avulso'
            ];
            FluxoCaixaServices::createFluxo($fluxo);

            \DB::commit();
            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
        } catch (Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        } catch (QueryException $q ) {
            \DB::rollBack();
            \Log::debug($q->getMessage());
            return response()->error('Problemas ao gravar registro! ');
        }
    }

    public function show($id){
        $Data = LancamentoAvulso::complete($id);
        if ($Data["tipo_cobranca"] == 'antiga'){
            $boleto = \DB::table('lancamentos_contas_receber as lcr')
                ->join('recebimento_lancamentos as rl','lcr.id','=','rl.id_lancamento_receber')
                ->join('recebimento_parcelas as r','rl.id_recebimento','=','r.id_recebimento')
                ->join('parcela_boletos as p','r.id','=','p.id_parcela')
                ->select('p.percentualmulta','p.percentualjuros','p.nosso_numero','p.numero_documento',
                    'p.aceite','p.especie_doc','r.id_situacao_inadimplencia')
                ->where('lcr.id_lancamento','=',$id)
                ->get();
            $Data["dados_boleto_antigo"] = $boleto[0];
        }

        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(LancamentoAvulsoRequest $request, $id){
        $dados = $request->all();
        $dados["id_empresa"] = NULL;
        $data_vencimento = DataHelper::setDate($dados['data_vencimento']);

        $lancamento = Lancamento::find($id);
        $lancamento_avulso = LancamentoAvulso::find($id);

        if (count($lancamento_avulso) and count($lancamento)) {
            try {
                \DB::beginTransaction();

                $lancamento->update($dados);
                $lancamento_avulso->update($dados);

                if($dados["tipo_cobranca"] == 'antiga'){
                    \DB::table('lancamentos_contas_receber as lcr')
                        ->where('lcr.id_lancamento','=',$id)
                        ->join('contas_receber as c','lcr.id_conta_receber','=','c.id')
                        ->update(['c.valor_total' => $dados["valor"],
                            'c.total_provisionado' => $dados["valor"],
                            'c.id_imovel' => $dados["idimovel"],
                            'data_agendamento' => $data_vencimento
                        ]);

                    $associado = ImovelPermanente::getTitularImovel($dados['idimovel']);

                    \DB::table('lancamentos_contas_receber as lcr')
                        ->where('lcr.id_lancamento','=',$id)
                        ->join('recebimento_lancamentos as rl','lcr.id','=','rl.id_lancamento_receber')
                        ->join('recebimentos as r','rl.id_recebimento','=','r.id')
                        ->join('recebimento_parcelas as rp','r.id','=','rp.id_recebimento')
                        ->join('parcela_boletos as b','rp.id','=','b.id_parcela')
                        ->update(['r.id_configuracao_carteira' => $dados["id_configuracao_carteira"],
                            'r.id_layout_remessa' => $dados["id_layout_remessa"],
                            'r.idimovel' => $dados["idimovel"],
                            'r.idassociado' => $associado->first()->id_pessoa,
                            'r.data_agendamento' => $data_vencimento,
                            'rp.valor' => $dados["valor"],
                            'rp.id_situacao_inadimplencia' => $dados["id_situacao_inadimplencia"],
                            'b.data_vencimento' => $data_vencimento,
                            'b.percentualmulta' => $dados["percentual_multa"],
                            'b.percentualjuros' => $dados["percentual_juros"],
                            'b.nosso_numero' => $dados["nosso_numero"],
                            'b.numero_documento' => $dados["numero_documento"],
                            'b.aceite' => $dados["aceite"],
                            'b.especie_doc' => $dados["especie_doc"]
                        ]);

                }

                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function updateLancamentoAntigo(LancamentoAvulsoRequest $dados){
        $data = $dados->all();
        $data["data_vencimento"] = $data["new_data_vencimento"];
        $data["data_competencia"] = $data["new_data_competencia"];
        $data["id_empresa"] = null;

        $lanc_antigo = LancamentoAntigo::find($data["id"]);

        try {
            \DB::beginTransaction();
            //LANCAMENTO ANTIGO
            $lanc_antigo->update($data);

            //ALTERA DADOS DA CONTA RECEBER
            $conta_receber = $lanc_antigo->lancamentos->first()->conta_receber->first();
            $conta_receber->valor_total = $data["valor"];
            $conta_receber->total_provisionado = $data["valor"];
            $conta_receber->data_agendamento = $data["data_competencia"];
            $conta_receber->update();

            //ALTERAÇÕES DOS LANCAMENTOS SE FOR PARA DELETAR, ALTERAR OU CRIAR NOVO
            foreach ($data["lancamentos"] as $lancamento){
                if(isset($lancamento["id"])){
                    if($lancamento["deleted"]){
                        Lancamento::find($lancamento["id"])->delete();
                    } else {
                        Lancamento::find($lancamento["id"])->update($lancamento);
                    }
                } else {
                    $lancamento["categoria"] = EnumCategoriaLancamento::toOrdinal($lancamento["categoria"]);
                    $lancamento["saldo_receber"] = 0;
                    $novo_lancamento = Lancamento::create($lancamento);
                    $lanc_antigo->lancamentos()->attach($novo_lancamento->id);
                    $conta_receber->lancamentos()->attach($novo_lancamento->id);
                }
            }
            //BUSCANDO DADOS DA RELAÇÃO ENTRE LANCAMENTO E RECEBIMENTO -> FEITO NA BUSCA DIRETO SEM USAR RELACIONAMENTO
            $lancamento_recebimento_id = $lanc_antigo->lancamentos->first()->conta_receber->first()->pivot->id;
            $lancamento_recebimento = \DB::table('recebimento_lancamentos')
                ->where('id_lancamento_receber',$lancamento_recebimento_id)->first();
            $recebimento = Recebimento::find($lancamento_recebimento->id_recebimento);
            $recebimento->id_configuracao_carteira = $data["id_configuracao_carteira"];
            $recebimento->id_layout_remessa = $data["id_layout_remessa"];
            $recebimento->data_agendamento = $data["data_vencimento"];
            $recebimento->update();

            //RECEBIMENTO_LANCAMENTOS
            foreach ($conta_receber->lancamentos as $lancamento) {
                $check_receb_lanc = \DB::table('recebimento_lancamentos')->where('id_lancamento_receber',$lancamento->pivot->id)->get();
                if ($check_receb_lanc->count() == 0) {
                    $recebimento->lancamentos()->attach($lancamento->pivot->id);
                }
            }

            //RECEBIMENTO PARCELAS
            $recebimento_parcela = $recebimento->parcelas->first();
            $recebimento_parcela->valor = $data["valor"];
            $recebimento_parcela->id_situacao_inadimplencia = $data["situacao_inadimplencia"];
            $recebimento_parcela->update();

            //PARCELAS BOLETO
            $boleto = ParcelaBoleto::find($recebimento_parcela->id);
            $boleto->data_vencimento = $data["data_vencimento"];
            $boleto->percentualmulta = $data["percentual_multa"];
            $boleto->percentualjuros = $data["percentual_juros"];
            $boleto->nosso_numero = $data["nosso_numero"];
            $boleto->numero_documento = $data["numero_documento"];
            $boleto->aceite = $data["aceite"] == 'true' ? 1 : 0;
            $boleto->especie_doc = $data["especie_doc"];
            $boleto->update();


            //FLUXO DE CAIXA
            $fluxo = [
                'id_conta_bancaria' => $lanc_antigo->carteira->conta_bancaria->id,
                'id_parcela' => $boleto->id_parcela,
                'valor' => $data['valor'],
                'data_vencimento' => DataHelper::setDate($data['data_vencimento']),
                'fluxo' => 'RECEITA',
                'tabela' => 'recebimento_parcela',
                'descricao' => 'Boleto '.$boleto->nosso_numero.' - Lançamento Avulso '.$data["descricao"],
                'referente' => $data["nome_titular"]
            ];
            if (FluxoCaixa::where('id_parcela',$boleto->id_parcela)->where('tabela','recebimento_parcela')->first()) {
                FluxoCaixaServices::updateFluxo($fluxo);
            } else {
                FluxoCaixaServices::createFluxo($fluxo);
            }

            \DB::commit();
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->error($e->getMessage());
        }
    }

    public function checkLancamentoAntigo($id_lancamento){
        $result = [];
        $result["check"] = true;
        $Data = \DB::table('lancamento_antigos AS la')
            ->join('lancamento_antigo_lancamentos as lal','lal.id_lancamento_antigo','la.id')
            ->join('lancamentos as l','l.id','lal.id_lancamento')
            ->join('lancamentos_contas_receber as lcr','lcr.id_lancamento','l.id')
            ->join('contas_receber as c','c.id','lcr.id_conta_receber')
            ->join('recebimento_lancamentos as rl','rl.id_lancamento_receber','lcr.id')
            ->join('recebimentos as rc','rc.id','rl.id_recebimento')
            ->join('recebimento_parcelas as r','r.id_recebimento','rl.id_recebimento')
            ->join('parcela_boletos as p','p.id_parcela','r.id')
            ->where('la.id',$id_lancamento)
            ->select('la.id AS lanc_antigo','c.id as id_conta_receber','rc.id as id_recebimento', 'p.id_parcela','p.situacao', 'r.data_recebimento')
            ->groupBy('la.id')
            ->first();
        if (count($Data) == 0){
            $result["check"] = false;
            $result["msg"] = 'Boleto do lançamento não foi encontrado!';
        } elseif (!is_null($Data->data_recebimento)){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser editado já está compensado!';
        } elseif ($Data->situacao == 'Negociado'){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser editado foi negociado em acordo!';
        }
        return response($result);
    }

    public function destroy($id){
        $Data = Lancamento::find($id);
        if (count($Data)) {
            try {
                \DB::beginTransaction();
                $Data->delete();
//                FluxoCaixa::where('id_parcela',$parcela["id"])->where('tabela','parcela_pagar')->delete();
                \DB::commit();
            } catch (Exception $e) {
                \DB::rollBack();
                return response()->error($e->getMessage);
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->success(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function search(Request $request){
        return response('not implemented');
    }

    public function gerarBoleto($id){
        try {
            $lancamento = Lancamento::find($id);
            $id_recebimento = LancamentosContaReceber::
            join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->select('id_recebimento')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $id)
                ->get();
            if (!count($id_recebimento)) {
                return response()->error('Lançamento nao foi provisionado');
            }
            $recebimento = Recebimento::complete($id_recebimento->first()->id_recebimento);
            $id_parcela = $recebimento->parcelas->first()->id;
            $boleto_service = new BoletoServices();
            return $boleto_service->visualizar_boleto($id_parcela, 'I');
        } catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error("Problemas ao gerar boleto!");
        }
    }

    public function download_remessa($id)
    {
        try {
            $id_recebimento = LancamentosContaReceber::
            join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->select('id_recebimento')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $id)
                ->get();
            if (!count($id_recebimento)) {
                return response()->error('Lançamento não foi provisionado');
            }

            $recebimento = Recebimento::complete($id_recebimento->first()->id_recebimento);
            $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);

            $boleto_service = new BoletoServices();
            $remessa = $boleto_service->download_remessa($parcela_boleto->id_parcela);
            $headers = array('Content-Type' => 'text/plan', 'Content-Disposition' => 'attachment"');
            return response()->download($remessa["file_path"], $remessa["file_name"], $headers);
        }  catch (\Exception $e) {
            \Log::error($e->getMessage());
            return response()->error('Problemas ao fazer o download da remessa! ' . $e->getMessage());
        }
    }

    public function enviarEmail($id){

        try {
            $condominio = Condominio::all('nome_fantasia','email');
            $lancamento = Lancamento::find($id);
            $id_recebimento = LancamentosContaReceber::
            join('recebimento_lancamentos', 'lancamentos_contas_receber.id', 'recebimento_lancamentos.id_lancamento_receber')
                ->select('id_recebimento')
                ->where('lancamentos_contas_receber.id_lancamento', '=', $id)
                ->get();
            if (!count($id_recebimento)) {
                return response()->success('Lancamento nao foi provisionado');
            }

            $recebimento = Recebimento::complete($id_recebimento->first()->id_recebimento);

            $parcela_boleto = ParcelaBoleto::find($recebimento->parcelas->first()->id);


            $boleto_service = new BoletoServices();
            $boleto_pdf = $boleto_service->visualizar_boleto($parcela_boleto->id_parcela,'S');

            $pessoa_permanente = PessoaPermanente::where('id_pessoa','=',$recebimento->idassociado)->get();

            $emails = explode(";", $pessoa_permanente->first()->email_alternativo);
            $infor_email = [
                'lancamentos'=>[
                    ['descricao'=>$lancamento->descricao, 'valor'=>DataHelper::getDoubleToReal($lancamento->valor)]
                ],
                'titulo'=>'Lançamento Avulso',
                'vencimento'=>$parcela_boleto->data_vencimento,
                'associado'=>$recebimento->associado->nome,
                'nome_condominio'=> $condominio->first()->nome_fantasia,
                'email_condominio'=> $condominio->first()->email,
                'total'=>DataHelper::getDoubleToReal($lancamento->valor)
            ];
            $sent = null;
            if (!$parcela_boleto->email_enviado) {
                if(\App::environment('production')) {
                    foreach ($emails as $email) {
                        if ($email) {
                            if (Validator::email()->validate($email)) {
                                $sent = \Mail::to($email)->send(new BoletoMail($infor_email, $boleto_pdf, ''));
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
                            }
                        }
                    }
                } else {
                    $sent = \Mail::to('desenvolvimento@uzer.com.br')->send(new BoletoMail($infor_email, $boleto_pdf, ''));
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
            } else {
                return response()->success("Email já enviado!");
            }
            if ($sent) {
                return response()->error("Problemas ao enviar e-mail!");
            } else {
                return response()->success("Email enviado com sucesso!");
            }
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        } catch (\Swift_RfcComplianceException $s){
            return response()->error($s->getMessage());
        }
    }

    public function antigos(Request $request){
        try {
            $req = $request->input();
            $Data = LancamentoAntigo::with('carteira')
                ->with('carteira')
                ->with('layout_remessa')
                ->with('imovel')
                ->with('empresa')
                ->with('lancamentos');
            if(isset($req['data_inicio']) && isset($req['data_fim'])){
                $Data = $Data->whereBetween('data_vencimento',[
                            DataHelper::setDate($req['data_inicio']),
                            DataHelper::setDate($req['data_fim'])
                        ]);
            }
            $Data = $Data->orderBy('id','DESC')->paginate(11);
            foreach ($Data->Items() as $item) {
                $lancamento_antigo = \DB::table('lancamentos_contas_receber as lcr')
                    ->join('contas_receber as cr','lcr.id_conta_receber', '=','cr.id')
                    ->join('recebimento_lancamentos as rl','lcr.id','=','rl.id_lancamento_receber')
                    ->join('recebimento_parcelas as r','rl.id_recebimento','=','r.id_recebimento')
                    ->join('parcela_boletos as p','r.id','=','p.id_parcela')
                    ->select('p.percentualmulta','p.percentualjuros','p.nosso_numero','p.numero_documento',
                        'p.aceite','p.especie_doc','r.id_situacao_inadimplencia', 'cr.data_agendamento')
                    ->where('lcr.id_lancamento','=',$item->lancamentos[0]->id)
                    ->first();
                $item["percentual_multa"] = $lancamento_antigo->percentualmulta;
                $item["percentual_juros"] = $lancamento_antigo->percentualjuros;
                $item["nosso_numero"] = (integer) $lancamento_antigo->nosso_numero;
                $item["numero_documento"] = $lancamento_antigo->numero_documento;
                $item["aceite"] = $lancamento_antigo->aceite;
                $item["especie_doc"] = $lancamento_antigo->especie_doc;
                $item["situacao_inadimplencia"] = $lancamento_antigo->id_situacao_inadimplencia;
                $item["data_competencia"] = DataHelper::getPrettyDate($lancamento_antigo->data_agendamento);

                if (!is_null($item->idimovel)) {
                    $morador = ImovelPermanente::where('id_imovel', '=', $item->idimovel)->where('pessoa_titular', '=', 1)->get();
                    if (count($morador)) {
                        $item['nome_morador'] = $morador->first()->pessoa->nome;
                    }
                }
                if (!is_null($item->id_empresa)) {
                    $empresa = Empresa::where('id', '=', $item->id_empresa)->get();
                    $item['nome_morador'] = $empresa->first()->nome_fantasia;
                }
            }
            return response($Data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        } catch (\Swift_RfcComplianceException $s){
            return response()->error($s->getMessage());
        }
    }

    public function cancelaLancamentoAvulso(Request $request){
        $lancamento = $request->all();
        $result = [];
        $result["check"] = true;

        $Data  = \DB::table('recebimento_parcelas as rp')
            ->join('recebimentos as r','r.id', 'rp.id_recebimento')
            ->join('recebimento_lancamentos as rl','rl.id_recebimento','r.id')
            ->join('lancamentos_contas_receber as lcr','lcr.id','rl.id_lancamento_receber')
            ->join('lancamentos as l','l.id','lcr.id_lancamento')
            ->join('parcela_boletos as p','p.id_parcela','rp.id')
            ->where('l.id',$lancamento["id"])
            ->select('l.id as id_lancamento','p.id_parcela','rp.data_recebimento','p.situacao')
            ->first();
        if (count($Data) == 0){
            $result["check"] = false;
            $result["msg"] = 'Boleto do lançamento não encontrado!';
            return $result;
        }
        if (!is_null($Data->data_recebimento)){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser cancelado já está compensado!';
            return $result;
        }
        if ($Data->situacao === 'Negociado'){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser cancelado foi negociado em acordo!';
            return $result;
        }
        $cancel_parcela = ParcelaBoleto::find($Data->id_parcela);
        $cancel_parcela->situacao = 'Cancelado';
        $cancel_parcela->update();

        $cancel_lancamento_avulso = LancamentoAvulso::find($Data->id_lancamento);
        $cancel_lancamento_avulso->cancelamento = 1;
        $cancel_lancamento_avulso->motivo_cancelamento = $lancamento["motivo"];
        $cancel_lancamento_avulso->update();

        //deleta fluxo
        FluxoCaixa::where('id_parcela',$Data->id_parcela)->where('tabela','recebimento_parcela')->delete();

        $result["msg"] = 'Lançamento avulso cancelado com sucesso!';

        return $result;
    }

    public function deletaLancamentoAntigo($id_lancamento_antigo){
        $result = [];
        $result["check"] = true;

        $Data = \DB::table('lancamento_antigos AS la')
            ->join('lancamento_antigo_lancamentos as lal','lal.id_lancamento_antigo','la.id')
            ->join('lancamentos as l','l.id','lal.id_lancamento')
            ->join('lancamentos_contas_receber as lcr','lcr.id_lancamento','l.id')
            ->join('contas_receber as c','c.id','lcr.id_conta_receber')
            ->join('recebimento_lancamentos as rl','rl.id_lancamento_receber','lcr.id')
            ->join('recebimentos as rc','rc.id','rl.id_recebimento')
            ->join('recebimento_parcelas as r','r.id_recebimento','rl.id_recebimento')
            ->join('parcela_boletos as p','p.id_parcela','r.id')
            ->where('la.id',$id_lancamento_antigo)
            ->select('la.id AS lanc_antigo','c.id as id_conta_receber','rc.id as id_recebimento', 'p.id_parcela','p.situacao', 'r.data_recebimento')
            ->groupBy('la.id')
            ->first();

        if (count($Data) == 0){
            $result["check"] = false;
            $result["msg"] = 'Boleto do lançamento não foi encontrado!';
            return $result;
        }
        if (!is_null($Data->data_recebimento)){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser cancelado já está compensado!';
            return $result;
        }
        if ($Data->situacao == 'Negociado'){
            $result["check"] = false;
            $result["msg"] = 'Título não pode ser cancelado foi negociado em acordo!';
            return $result;
        }

        try {
            \DB::beginTransaction();
                ParcelaBoleto::find($Data->id_parcela)->delete();
                RecebimentoParcela::find($Data->id_parcela)->delete();
                Recebimento::find($Data->id_recebimento)->delete();
                $lanc_ids = LancamentoAntigo::find($id_lancamento_antigo)->lancamentos->modelKeys();//pega todos ids dos lancamentos q trouxe na relação. ;) massa!
                Lancamento::whereIn('id', $lanc_ids)->delete();
                ContasReceber::find($Data->id_conta_receber)->delete();
                LancamentoAntigo::find($id_lancamento_antigo)->delete();
                FluxoCaixa::where('id_parcela',$Data->id_parcela)->where('tabela','recebimento_parcela')->delete(); //deleta no fluxo
                $result["msg"] = 'Lançamento antigo excluído com sucesso!';
            \DB::commit();

        } catch (Exception $e) {
            \DB::rollBack();
            $result["check"] = false;
            $result["msg"] = $e->getMessage;
        }

        return $result;
    }
}