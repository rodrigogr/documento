<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia';
    protected $fillable = [
        'tipo',
        'status',
        'titulo',
        'data_hora_inicio',
        'data_hora_fim',
        'link_transmissao',
        'votacao_secreta'
    ];

    public function participantes()
    {
        return $this->hasMany(Participante::class);
    }

    public function assem_encaminnhamentos()
    {
        return $this->hasMany(Assem_Encaminhamento::class);
    }

    public function assem_discussoes()
    {
        return $this->hasMany(Assem_Discussao::class);
    }

    public function assem_questoes_ordens()
    {
        return $this->hasMany(Assem_Questao_Ordem::class);
    }

    public function pautas()
    {
        return $this->hasMany(Pauta::class);
    }

    public function assembleia_documentos()
    {
        return $this->hasMany(Assembleia_Documento::class);
    }
}