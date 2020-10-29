<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    public $timestamps = false;
    protected $table = 'empresa';
    protected $fillable = [
        'data_cadastro',
        'razao_social',
        'nome_fantasia',
        'cnpj',
        'ie',
        'contato',
        'email',
        'obs',
        'data_atualizacao',
        'tel1',
        'tel2',
        'endereco',
        'cidade',
        'estado',
        'tipo',
        'cep',
        'complemento',
        'ramo_atividade',
        'bairro',
        'numero'
    ];
}
