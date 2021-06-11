<?php

namespace App\Http\Controllers\Reservas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Reservas\LocalReservavelRequest;
use App\Models\Reservas\DiaInativoLocalReservavel;
use App\Models\Reservas\LocalReservavel;
use App\Models\Reservas\PeriodoLocalReservavel;
use App\Models\Reservas\Reserva;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use League\Flysystem\Adapter\Local;

class LocalReservavelController extends Controller
{
    private $name = 'Local Reservável';

    public function index()
    {
        $Data = LocalReservavel::simples();
        if (count($Data)) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
    }

    public function store(LocalReservavelRequest $request)
    {
        try {
            $data = $request->all();
            if (!empty($data["regra_local"])) {
                $resultFile = $this->salvaArquivo($data["regra_local"]);
                if ($resultFile["error"]) {
                    return response()->error($resultFile["error"]);
                } else {
                    $data["regra_local"] = $resultFile["file"];
                }
            }

            $local = LocalReservavel::create($data);

            if ($local->id) {
                foreach ($data["periodo"] as $key => $periodo) {
                    foreach ($periodo as $item) {
                        $arrPeriodo = ['id_local_reservavel' => $local->id, 'dia_semana' => $key, 'hora_ini' => $item["hora_ini"], 'hora_fim' => $item["hora_fim"], 'valor' => $item["valor"]];
                        if ($item["hora_ini"]) {
                            if ($arrPeriodo['valor'] == '') {
                                $arrPeriodo['valor'] = 0.00;
                            }
                            PeriodoLocalReservavel::insert($arrPeriodo);
                        }
                    }
                }

                foreach ($data["dia_inativo"] as $diaInativo) {
                    $arrDiaInativo = ['id_local_reservavel' => $local->id, 'data' => $diaInativo["data"], 'descricao' => $diaInativo["descricao"], 'repetir' => $diaInativo["repetir"]];
                    if ($diaInativo["data"]) {
                        $dataFormatada = Carbon::createFromFormat('d/m/Y', $diaInativo["data"])->format('Y-m-d');
                        $arrDiaInativo["data"] = $dataFormatada;
                        DiaInativoLocalReservavel::insert($arrDiaInativo);
                    }
                }
            }

            return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));

        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function show($id)
    {
        $Data = LocalReservavel::complete($id);
        /*$url = \Storage::disk('public')->url($Data["regra_local"]);
        $Data["regra_local"] = public_path($url);*/
        if ($Data) {
            return response()->success($Data);
        }
        return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
    }

    private function itensAlterar ($arr) {
        return $arr["id"] and !$arr["deleted"];
    }

    public function update(LocalReservavelRequest $request, $id)
    {
        try {
            $data = $request->all();
            //\Log::debug($data["periodo"]);

            $Data = LocalReservavel::find($id);

            if ($data["regra_local"] != $Data["regra_local"]) {
                $resultFile = $this->salvaArquivo($data["regra_local"]);
                if ($resultFile["error"]) {
                    return response()->error($resultFile["error"]);
                } else {
                    $data["regra_local"] = $resultFile["file"];
                }
            }
            $Data->update($data);

            //deleta todos e depois cria de novo
            //$periodoDel = PeriodoLocalReservavel::where('id_local_reservavel',$id);
            //$periodoDel->delete();

            foreach ($data["periodo"] as $key => $dia_semana) {
                foreach ($dia_semana as $dados_dia) {
                    /*$dados_dia["id_local_reservavel"] = $id;
                    $dados_dia["dia_semana"] = $key;
                    $dados_dia["valor"] = (float)$dados_dia["valor"];
                    PeriodoLocalReservavel::create($dados_dia);*/

                    if (!isset($dados_dia["id"]) && $dados_dia["hora_ini"]) {
                        $dados_dia["id_local_reservavel"] = $id;
                        $dados_dia["dia_semana"] = $key;
                        $dados_dia["valor"] = (float)$dados_dia["valor"];
                        PeriodoLocalReservavel::create($dados_dia);
                    }
                    if (isset($dados_dia["id"]) && $dados_dia["hora_ini"] && (isset($dados_dia["deleted"]) && !$dados_dia["deleted"])) {
                        $periodoAlt = PeriodoLocalReservavel::find($dados_dia["id"]);
                        $periodoAlt->id_local_reservavel = $id;
                        $periodoAlt->dia_semana = $key;
                        $periodoAlt->hora_ini = $dados_dia["hora_ini"];
                        $periodoAlt->hora_fim = $dados_dia["hora_fim"];
                        $periodoAlt->valor = (float)$dados_dia["valor"];
                        $periodoAlt->save();
                    }
                    if (isset($dados_dia["deleted"]) && $dados_dia["deleted"] && isset($dados_dia["id"])) {
                        $periodoDel = PeriodoLocalReservavel::find($dados_dia["id"]);
                        $periodoDel->delete();
                    }
                }
            }

            foreach ($data["dia_inativo"] as $dia_inativo) {
                if (!isset($dia_inativo["id"])) {
                    $dia_inativo["id_local_reservavel"] = $id;
                    unset($dia_inativo['deleted']);
                    $dataFormatada = Carbon::createFromFormat('d/m/Y', $dia_inativo["data"])->format('Y-m-d');
                    $dia_inativo["data"] = $dataFormatada;
                    DiaInativoLocalReservavel::insert($dia_inativo);
                }
                if (isset($dia_inativo["id"]) && !$dia_inativo["deleted"]) {
                    $dataFormatada = Carbon::createFromFormat('d/m/Y', $dia_inativo["data"])->format('Y-m-d');
                    $dia_inativo["data"] = $dataFormatada;
                    $diaAlt = DiaInativoLocalReservavel::find($dia_inativo["id"]);
                    $diaAlt->id_local_reservavel = $id;
                    $diaAlt->data = $dia_inativo["data"];
                    $diaAlt->descricao = $dia_inativo["descricao"];
                    $diaAlt->repetir = $dia_inativo["repetir"];
                    $diaAlt->save();
                }
                if (isset($dia_inativo["deleted"]) && $dia_inativo["deleted"]) {
                    $diaDel = DiaInativoLocalReservavel::find($dia_inativo["id"]);
                    $diaDel->delete();
                }
            }

            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));

        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function nomeLocalReservavel($nome_local)
    {
        try {
            $Data = LocalReservavel::nomeLocalReservavel($nome_local);
            return response()->success($Data);

        } catch (\Exception $e) {
            return response()->error(trans('messages.crud.MAE', ['name' => $this->name]));
        }
    }

    public function excluirLocal($id)
    {
        LocalReservavel::find($id)->delete();
        Reserva::where('id_local_reservavel', $id)->delete();

        return response()->success("Excluído com sucesso!");

    }

    private function getExtensao($arquivo)
    {
        switch ($arquivo) {
            case "vnd.openxmlformats-officedocument.wordprocessingml.document":
            case "msword":
                return 'doc';
            case "plain":
                return 'txt';
            case "application/vnd.oasis.opendocument.text":
                return 'odt';
            case "application/vnd.oasis.opendocument.spreadsheet":
                return 'ods';
            case "pdf":
                return 'pdf';
            case "vnd.openxmlformats-officedocument.spreadsheetml.sheet":
            case "vnd.ms-office":
                return 'xls';
            case "jpg":
            case "jpeg":
                return 'jpg';
            case "png":
                return 'png';

        }
    }

    private function salvaArquivo($arquivo)
    {
        $base64 = explode('base64,', $arquivo);
        $file = base64_decode($base64[1], true);
        $mimetype = explode('/', mime_content_type($arquivo))[1];
        \Log::debug('mimetype: '.$mimetype);
        $extensao = $this->getExtensao($mimetype);
        $nameFile = time().random_int(500,999).'.'.$extensao;
        //salva da pasta
        \Storage::disk('public')->put($nameFile, $file);
        //get size para comparar o tamanho permitido
        $size = \Storage::disk('public')->size($nameFile);

        $result = [
            "file" => $nameFile,
            "error" => false
        ];

        if ($size > 10485760) {
            //deleta o arquivo
            \Storage::disk('public')->delete($nameFile);
            $result["error"] = 'Arquivo não pode ser maior que 10 MB.';
        }

        return $result;
    }

    public function urlDoc($arquivo)
    {
        return response()->file('storage/'.$arquivo);
    }
}