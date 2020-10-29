<?php

namespace App\Http\Controllers;

use App\Http\Requests\InadimplenciaRequest;
use App\Models\ImovelPermanente;
use App\Models\RecebimentoParcela;


class InadimplenciaController extends Controller
{
    private $name = 'Classificação de Incadimplências';

    public function listaInadimplentes(InadimplenciaRequest $request)
    {
        $data = $request->all();
        $query = \DB::table('recebimentos as r');
        if(isset($data["id_pessoa"]) && $data["id_pessoa"] != ""){
            $id_pessoa = $data["id_pessoa"];
            $parcialQuery = $query->join('imovel_permanente as i', function ($q) use ($id_pessoa) {
                $q->on('i.id_pessoa','r.idassociado');
                $q->where('i.id_pessoa',$id_pessoa);
            })
                ->join('pessoa as p', 'p.id', '=', 'i.id_pessoa')
                ->join('imovel as im','i.id_imovel','=','im.id')
                ->leftJoin('empresa as e','r.id_empresa','=','e.id')
                ->select('pb.id_parcela AS id_boleto','rp.valor','im.id as id_imovel','e.id as id_empresa','im.quadra','im.lote','p.nome','pb.data_vencimento',
                    \DB::raw('CONCAT(t.descricao, "-" ,s.descricao) AS situacao_inadimplencia'),'pb.situacao');
        } elseif(isset($data["id_imovel"]) && !empty($data["id_imovel"])) {
            $parcialQuery = $query->join('imovel_permanente as i', function ($q) {
                $q->on('r.idimovel', 'i.id_imovel');
                $q->where('i.pessoa_titular', 1);
                $q->where('i.excluido','=','n');
            })
                ->join('pessoa as p', 'p.id', '=', 'id_pessoa')
                ->join('imovel as im','r.idimovel','=','im.id')
                ->leftJoin('empresa as e','r.id_empresa','=','e.id')
                ->select('pb.id_parcela AS id_boleto','rp.valor','im.id as id_imovel','e.id as id_empresa','im.quadra','im.lote','p.nome','pb.data_vencimento',
                    'rp.id_situacao_inadimplencia',\DB::raw('CONCAT(t.descricao, "-" ,s.descricao) AS situacao_inadimplencia'),'pb.situacao')
                ->where('r.idimovel',$data["id_imovel"]);
        } elseif(isset($data["id_empresa"]) && !empty($data["id_empresa"])) {
            $parcialQuery = $query->join('empresa as e','r.id_empresa','=','e.id')
                ->leftJoin('imovel as im','r.idimovel','=','im.id')
                ->select('pb.id_parcela AS id_boleto','rp.valor','e.id as id_empresa','e.nome_fantasia as nome','im.id as id_imovel','pb.data_vencimento',
                    \DB::raw('CONCAT(t.descricao, "-" ,s.descricao) AS situacao_inadimplencia'),'pb.situacao')
                ->where('r.id_empresa',$data["id_empresa"]);
        } else {
            $parcialQuery = $query->join('imovel_permanente as i', function ($q) {
                $q->on('r.idimovel', 'i.id_imovel');
                $q->where('i.pessoa_titular', 1);
                $q->where('i.excluido','=','n');
            })
                ->join('pessoa as p', 'p.id', '=', 'id_pessoa')
                ->join('imovel as im','r.idimovel','=','im.id')
                ->leftJoin('empresa as e','r.id_empresa','=','e.id')
                ->select('pb.id_parcela AS id_boleto','rp.valor','im.id as id_imovel','e.id as id_empresa','im.quadra','im.lote','p.nome','pb.data_vencimento',
                    'rp.id_situacao_inadimplencia',\DB::raw('CONCAT(t.descricao, "-" ,s.descricao) AS situacao_inadimplencia'),'pb.situacao')
                ->where('im.quadra','like','%'.$data["quadra"].'%')
                ->where('im.lote','like','%'.$data["lote"].'%');
        }

        $result = $parcialQuery->leftJoin('recebimento_parcelas AS rp','r.id','=','rp.id_recebimento')
            ->whereNull('rp.deleted_at')
            ->join('parcela_boletos AS pb ', function($q2){
                $q2->on('rp.id','pb.id_parcela');
                $q2->where([
                    ['pb.data_vencimento','<',\DB::raw("CURDATE()")],
                    ['pb.situacao' , 'Provisionado'],
                ]);
                $q2->whereNull('pb.deleted_at');
            })
            ->leftJoin('situacao_inadimplencias AS s','rp.id_situacao_inadimplencia','=','s.id')
            ->leftJoin('tipo_inadimplencias AS t','s.idtipo_inadimplencia','=','t.id')
            ->orderBy('pb.data_vencimento','desc')
            ->get();
        return response()->success($result);
    }

    public function classificar(InadimplenciaRequest $request)
    {
        $dados = $request->all();
        try {
            foreach ($dados as $items) {
                if(empty($items["id_situacao_inadimplencia"])){
                    $items["id_situacao_inadimplencia"] = null;
                }
                RecebimentoParcela::where('id',$items["id_boleto"])->update(['id_situacao_inadimplencia' => $items["id_situacao_inadimplencia"]]);
            }
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.FUS', ['name' => $this->name]));
    }
}