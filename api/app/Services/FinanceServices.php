<?php
/**
 * Created by PhpStorm.
 * User: rafael
 * Date: 21/12/2017
 * Time: 17:52
 */
namespace App\Services;
use App\Models\Feriado;
use Carbon\Carbon;

class FinanceServices
{
    public function verificaDiaUtil (Carbon $data, $saida = 'd/m/Y')
    {
        // Converte $data em um UNIX TIMESTAMP
        $timestamp = strtotime($data);

        // Calcula qual o dia da semana de $data
        // O resultado será um valor numérico: 1 -> Segunda ... 7 -> Domingo
        $dia = date('N', $timestamp);

        // Se for sábado (6) ou domingo (7), calcula a próxima segunda-feira
        if ($dia >= 6) {
            $timestamp_final = $timestamp + ((8 - $dia) * 3600 * 24);
            return $this->verificaDiaUtil($data->timestamp($timestamp_final));
        }
        if ($this->verificaFeriado($data) == true) {
            return $this->verificaDiaUtil($data->addDay(1));
        }
        return $data;
    }

    private function verificaFeriado (Carbon $data)
    {
        //Verifica se a data é feriado nacional
        if (in_array($data->format('d/m/Y'),$this->feriadosNacionais($data->year))) {
            return true;
        }
        //Busca os feriados da base.
        $feriados = Feriado::where('data',$data->format('d/m/Y'))->get();

        //Verifa se tem feriado refente a data.
        if(count($feriados)){
            return true;
        }
        return false;
    }

    private function feriadosNacionais($ano)
    {
        $feriados = array
        (
            // Armazena feriados fíxos
            date('d/m/Y', mktime(0, 0, 0, '01', '01', $ano)), // 01/01 Ano novo
            date('d/m/Y', mktime(0, 0, 0, '04', '21', $ano)), // 21/04 Tiradentes
            date('d/m/Y', mktime(0, 0, 0, '05', '01', $ano)), // 01/05 Dia do trabalho
            date('d/m/Y', mktime(0, 0, 0, '09', '07', $ano)), // 07/09 Independencia
            date('d/m/Y', mktime(0, 0, 0, '10', '12', $ano)), // 12/10 Aparecida
            date('d/m/Y', mktime(0, 0, 0, '11', '02', $ano)), // 02/11 Finados
            date('d/m/Y', mktime(0, 0, 0, '11', '15', $ano)), // 15/11 Proclamação
            //date(FR_DATA, mktime(0,0,0,'12','24',$ano)), // 24/12 Véspera de Natal
            date('d/m/Y', mktime(0, 0, 0, '12', '25', $ano)), // 25/12 Natal
            //date(FR_DATA, mktime(0,0,0,'12','31',$ano)), // 31/12 Véspera de Ano novo

            // Armazena feriados variáveis
            $this->flxFeriado($ano, 'pascoa', $r = 1), // Páscoa - Sempre domingo
            $this->flxFeriado($ano, 'carn_sab', $r = 1), // Carnaval - Sempre sábado
            $this->flxFeriado($ano, 'carn_dom', $r = 1), // Carnaval - Sempre domingo
            $this->flxFeriado($ano, 'carn_seg', $r = 1), // Carnaval - Segunda
            $this->flxFeriado($ano, 'carn_ter', $r = 1), // Carnaval - Terça
            //strtoupper(flxFeriado($ano, 'carn_qua', $r = 1)), // Carnaval - Quarta de cinza
            $this->flxFeriado($ano, 'sant_sex', $r = 1), // Sexta Santa
            $this->flxFeriado($ano, 'corp_chr', $r = 1)  // Corpus Christi
        );
        return $feriados;
    }

    private function flxFeriado($ano, $tipo = NULL)
    {
        $a = explode("/", $this->calPascoa($ano));
        switch ($tipo) {
            case 'carn_sab':
                $d = $a[0] - 50;
                break;
            case 'carn_dom':
                $d = $a[0] - 49;
                break;
            case 'carn_seg':
                $d = $a[0] - 48;
                break;
            case 'carn_ter':
                $d = $a[0] - 47;
                break;
            case 'carn_qua':
                $d = $a[0] - 46;
                break;
            case 'sant_sex':
                $d = $a[0] - 2;
                break;
            case 'corp_chr':
                $d = $a[0] + 60;
                break;
            case NULL:
            case 'pascoa':
                $d = $a[0];
                break;
        }
        return date('d/m/Y', mktime(0, 0, 0, $a[1], $d, $a[2]));
    }

    private function calPascoa($ano)
    {
        $A = ($ano % 19);
        $B = (int)($ano / 100);
        $C = ($ano % 100);
        $D = (int)($B / 4);
        $E = ($B % 4);
        $F = (int)(($B + 8) / 25);
        $G = (int)(($B - $F + 1) / 3);
        $H = ((19 * $A + $B - $D - $G + 15) % 30);
        $I = (int)($C / 4);
        $K = ($C % 4);
        $L = ((32 + 2 * $E + 2 * $I - $H - $K) % 7);
        $M = (int)(($A + 11 * $H + 22 * $L) / 451);
        $P = (int)(($H + $L - 7 * $M + 114) / 31);
        $Q = (($H + $L - 7 * $M + 114) % 31) + 1;
        return date('d/m/Y', mktime(0, 0, 0, $P, $Q, $ano));
    }
}