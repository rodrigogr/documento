<?php

namespace App\models\Assembleia;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Assembleia extends Model
{
    public $timestamps = true;

    static public $associations = [
        'pautas ',
        'documentos'
    ];

    protected $fillable = [
        'tipo',
        'status',
        'titulo',
        'data_inicio',
        'hora_inicio',
        'data_fim',
        'hora_fim',
        'link_transmissao',
        'votacao_secreta'
    ];

//    public function setVotacaoSecretaAttribute($value)
//    {
//        return $this->attributes['votacao_secreta'] = $value;
//    }
//
//    public function setLinkTransmissaoAttribute($value)
//    {
//        return $this->attributes['link_transmissao'] = $value;
//    }

    public function setDataHoraInicioAttribute($value)
    {
        return $this->attributes['data_inicio'] = DataHelper::setDate($value);
    }

    public function setDataHoraFimAttribute($value)
    {
        return $this->attributes['data_fim'] = DataHelper::setDate($value);
    }

    public function participantes()
    {
        return $this->hasMany(AssembleiaParticipante::class, 'id_assembleia');
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
        return $this->hasMany(Pauta::class, 'id_assembleia');
    }

    public function documentos()
    {
        return $this->hasMany(AssembleiaDocumento::class, 'id_assembleia');
    }
}