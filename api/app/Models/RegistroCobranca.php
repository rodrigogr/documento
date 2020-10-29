<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RegistroCobranca extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'id_boleto',
        'id_imovel',
        'id_empresa',
        'endereco',
        'nome',
        'modelo',
        'data_vencimento',
        'data_envio',
        'conteudo'
    ];
}
