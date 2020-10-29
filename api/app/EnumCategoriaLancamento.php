<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EnumCategoriaLancamento
{
    private static $enum = array(1 => "Taxa", 2 => "Fundo", 3=> "Outros", 4=> "Custas", 5=> "Multa", 6=>"Juros", 7=> "Descontos", 8=> "Juridico", 9=> "Correcoes",  10=> "Abatimentos");

    static public function toOrdinal($name) {
        return array_search($name, self::$enum);
    }

    static public function toString($ordinal) {
        return self::$enum[$ordinal];
    }
}