<?php

namespace App\Helpers;

use Carbon\Carbon;

class DataHelper
{
    // ******************** FUNCTIONS ******************************
    static public function getReal2Float($value){
        return floatval(str_replace(',', '.', str_replace('.', '', $value)));
    }

    static public function getFloat2Real($value){
        return number_format($value, 2, ',', '.');
    }

    static public function getDoubleToReal($value){
        return number_format($value,  2, ',', '.');
    }

    static public function getRealToDouble($value){
        return doubleval(str_replace(',','.',str_replace('.','',$value)));
    }

    static public function getPrettyDateTime($value){
        if($value == NULL) return $value;
        $value = DataHelper::setDate($value);
        return date_format(date_create($value), "H:i - d/m/Y");
    }

    static public function getPrettyDate($value){
        if($value == NULL) return $value;
        $value = DataHelper::setDate($value);
        return date_format(date_create($value), "d/m/Y");
    }

    static public function setDate($value){
        if(DataHelper::validate_date($value)) {
            $retorno = Carbon::createFromFormat('d/m/Y', $value)->format('Y-m-d');
        } elseif(strpos($value, '-')) {
            $retorno = date_create($value)->format('Y-m-d');
        } elseif($value == '') {
            $retorno = null;
        } else {
            $retorno = $value;
        }
        return $retorno;
    }
    static public function setDateTimeToDate($value){
        $retorno = Carbon::createFromFormat('d/m/Y H:i:s', $value)->format('Y-m-d');
        return $retorno;
    }

    static public function setDateUTCtoDateDB($value,$time = null){
        $data = Carbon::createFromFormat('Y-m-d\TH:i:s.uO', $value);
        return $data->format('Y-m-d H:i:s') ;
    }

    static public function getOnlyNumbers($value){
        return ($value != NULL) ? preg_replace("/[^0-9]/", "", $value) : $value;
    }

    static public function mask($val, $mask){
        if ($val != NULL || $val != "") {
            $maskared = '';
            $k = 0;
            for ($i = 0; $i <= strlen($mask) - 1; $i++) {
                if ($mask[$i] == '#') {
                    if (isset($val[$k])) $maskared .= $val[$k++];
                } else {
                    if (isset($mask[$i])) $maskared .= $mask[$i];
                }
            }
        } else {
            $maskared = NULL;
        }
        return $maskared;
    }

    static public function generationDate($dia){
    }

    static public function getxDecimalCurrency($value, $x){
        return number_format($value,$x,',', '.');
    }

    static public function validaCPF($cpf) {
        // Extrai somente os números
        $cpf = preg_replace( '/[^0-9]/is', '', $cpf );
        // Verifica se foi informado todos os digitos corretamente
        if (strlen($cpf) != 11) {
            return false;
        }
        // Verifica se foi informada uma sequência de digitos repetidos. Ex: 111.111.111-11
        if (preg_match('/(\d)\1{10}/', $cpf)) {
            return false;
        }
        // Faz o calculo para validar o CPF
        for ($t = 9; $t < 11; $t++) {
            for ($d = 0, $c = 0; $c < $t; $c++) {
                $d += $cpf{$c} * (($t + 1) - $c);
            }
            $d = ((10 * $d) % 11) % 10;
            if ($cpf{$c} != $d) {
                return false;
            }
        }
        return true;
    }

    static public function validaCNPJ($cnpj)
    {
        $cnpj = preg_replace('/[^0-9]/', '', (string) $cnpj);
        // Valida tamanho
        if (strlen($cnpj) != 14)
            return false;
        // Valida primeiro dígito verificador
        for ($i = 0, $j = 5, $soma = 0; $i < 12; $i++)
        {
            $soma += $cnpj{$i} * $j;
            $j = ($j == 2) ? 9 : $j - 1;
        }
        $resto = $soma % 11;
        if ($cnpj{12} != ($resto < 2 ? 0 : 11 - $resto))
            return false;
        // Valida segundo dígito verificador
        for ($i = 0, $j = 6, $soma = 0; $i < 13; $i++)
        {
            $soma += $cnpj{$i} * $j;
            $j = ($j == 2) ? 9 : $j - 1;
        }
        $resto = $soma % 11;
        return $cnpj{13} == ($resto < 2 ? 0 : 11 - $resto);
    }

    static private function validate_date( $date ) {
        if ( ! strpos( $date, '/' ) ) {
            return false;
        }
        if ( substr_count( $date, '/' ) !== 2 ) {
            return false;
        }
        if ( preg_match( '/^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/', $date ) !== 1 ) {
            return false;
        }
        $split = explode( '/', $date );
        return checkdate( $split[1], $split[0], $split[2] );
    }
}