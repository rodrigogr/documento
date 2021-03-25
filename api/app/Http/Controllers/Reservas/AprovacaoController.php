<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;
use App\Services\Reservas\ReservaService;
use Illuminate\Http\Request;

class AprovacaoController extends Controller
{
    private $name = 'Aprovação';

    public function pendentes(Request $request)
    {
        $dados = $request->all();

        if ($dados["data"] && $dados["data"] != 'todos') {
            $dataHoje = strtotime(date('Y-m-d'));
            $dataBusca = strtotime(date($dados["data"]));
            //echo "hoje: ".date('Y-m-d')." ## dataBusca: ".date($dados["data"])."<br>".$dataHoje.' ## '.$dataBusca;
            if ($dataBusca < $dataHoje) {
                return response()->success([]);
            }
        }
        $Data = Reserva::aprovacoes($this->filtroBuscaAprovacoes($dados));

        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function pendentesHojeLocalReservavel($local)
    {
        $hoje = date('Y-m-d');
        //$dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacoes($hoje, $local);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function pendentesHojeLocalidade($localidade)
    {
        $hoje = date('Y-m-d');
        //$dia_semana = ReservaService::diaSemana($hoje);
        $Data = Reserva::aprovacoes($hoje,false, $localidade);
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function aprovacao($id, Request $request)
    {
        try {
            $reserva = Reserva::find($id);
            $reserva->status = 'aprovada';
            $reserva->update();
            return response()->success(trans('messages.crud.MUS', ['name' => 'Reserva']));

        } catch(\Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function recusar(Request $request)
    {
        $usuario = \Auth::user();

        try {
            $Data = $request->all();
            $reserva = Reserva::find($Data["id"]);
            $reserva->status = 'recusado';
            $reserva->obs = $Data["motivo"];
            $reserva->autor = $usuario->id_pessoa_bioacesso;
            $reserva->update();
            return response()->success(trans('messages.crud.FUS', ['name' => 'Reserva ']));

        } catch(\Exception $e) {
            return response()->error($e->getMessage);
        }
    }

    public function recusados($data)
    {
        if ($data == 'todos') {
            $Data = Reserva::aprovacoes($data,'','','recusado');
        } else {
            //$dia_semana = ReservaService::diaSemana($data);
            $Data = Reserva::aprovacoes($data);
        }

        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function recusadosLocalReservavel($localReservavel)
    {
        $Data = Reserva::aprovacoes('todos',$localReservavel, '','recusado');

        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function recusadosLocalidade($localidade)
    {
        $Data = Reserva::aprovacoes('todos','' , $localidade,'recusado');

        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    private function filtroBuscaAprovacoes($dados){
        return [
            "data" => $dados["data"] ? $dados["data"] : '',
            "localReservavel" => $dados["localReservavel"] ? $dados["localReservavel"] : '',
            "localidade" => $dados["localidade"] ? $dados["localidade"] : '',
            "status" => $dados["status"] ? $dados["status"] : '',
        ];
    }
}