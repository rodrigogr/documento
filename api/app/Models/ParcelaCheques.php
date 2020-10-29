<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ParcelaCheques extends RecebimentoParcela
{
    protected $fillable = [
        'id_parcela',
        'data_emissao',
        'data_predatado',
        'codigo_banco',
        'agencia',
        'numero_cheque',
        'data_vencimento'

    ];
}
