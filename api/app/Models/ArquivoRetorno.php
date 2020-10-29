<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ArquivoRetorno extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'nome_arquivo',
        'caminho_arquivo',
        'layout',
        'data_leitura',
        'qtd_processado',
        'qtd_recebida',
        'qtd_rejeitada',
        'outras_operacoes'
    ];

    public function titulos_processado()
    {
        return $this->hasMany('App\Models\TitulosProcessado','id_arquivo_retorno');
    }
}
