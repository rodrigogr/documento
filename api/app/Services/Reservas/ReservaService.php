<?php
namespace App\Services\Reservas;

class ReservaService
{
    public static function diaSemana($data)
    {
        $semana = array('dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab');
        $data = date($data);
        $dia_semana_numero = date('w', strtotime($data));

        return $semana[$dia_semana_numero];
    }

    public static function enviarNotificacao($titulo, $mensagem, $idPessoa)
    {
        $data = [
            "titulo" => $titulo,
            "mensagem" => $mensagem,
            "id_pessoa" => $idPessoa
        ];

        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => env('APP_URL_PORTAL') .'/api/v1.1/notificacao/reserva',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => array(
                "content-type: application/json"
            ),
        ));

        curl_exec($curl);
        //$err = curl_error($curl);

        curl_close($curl);

        /*if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            echo $response;
        }*/
    }
}