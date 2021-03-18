<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia extends Model
{
    public $timestamps = true;
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

    public function assembleiaEncaminnhamentos()
    {
        return $this->hasMany(AssembleiaEncaminhamento::class);
    }

    public function assembleiaDiscussoes()
    {
        return $this->hasMany(AssembleiaDiscussao::class);
    }

    public function assembleiaQuestoesOrdens()
    {
        return $this->hasMany(AssembleiaQuestaoOrdem::class);
    }

    public function pautas()
    {
        return $this->hasMany(Pauta::class);
    }

    public function assembleiaDocumentos()
    {
        return $this->hasMany(AssembleiaDocumento::class);
    }
}