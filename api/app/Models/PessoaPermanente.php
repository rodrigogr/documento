<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PessoaPermanente extends Model
{
    public $timestamps = false;
    protected $table = 'pessoa_permanente';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_pessoa',
        'codigo',
        'pai',
        'nacionalidade',
        'naturalidade',
        'profissao',
        'email',
        'ativo',
        'id_imovel',
        'ultima_atualizacao',
        'tipo',
        'senha',
        'grau_parentesco',
        'permitir_liberacao',
        'associado',
        'chefe_imediato',
        'id_empresa',
        'data_vencimento',
        'categoria',
        'tipo_servico',
        'permitir_cad_permanente',
        'id_pessoa_autorizante',
        'id_endereco',
        'end_secundario_correspondencia',
        'email_alternativo'
    ];


    public function endereco_secundario()
    {
        return $this->belongsTo('App\Models\Endereco', 'id_endereco');
    }
}
