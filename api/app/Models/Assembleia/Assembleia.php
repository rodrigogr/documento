<?php

namespace App\models\Assembleia;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Assembleia extends Model
{
    public $timestamps = true;

    static public $associations = [
        'pautas',
        'documentos',
        'participantes'
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
        'votacao_secreta',
        'votacao_data_fim',
        'votacao_hora_fim'

    ];
    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function setDataInicioAttribute($value)
    {
        return $this->attributes['data_inicio'] = DataHelper::setDate($value);
    }

    public function setDataFimAttribute($value)
    {
        return $this->attributes['data_fim'] = DataHelper::setDate($value);
    }

    public function getDataInicioAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function getDataFimAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setVotacaoDataInicioAttribute($value)
    {
        return $this->attributes['votacao_data_inicio'] = DataHelper::setDate($value);
    }
    public function getVotacaoDataInicioAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setVotacaoDataFimAttribute($value)
    {
        return $this->attributes['votacao_data_fim'] = DataHelper::setDate($value);
    }

    public function getVotacaoDataFimAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
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
        return $this->hasMany(AssembleiaPauta::class, 'id_assembleia');
    }

    public function documentos()
    {
        return $this->hasMany(AssembleiaDocumento::class, 'id_assembleia');
    }
}