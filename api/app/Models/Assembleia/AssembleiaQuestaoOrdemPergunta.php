<?php


namespace App\Models\Assembleia;


use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class AssembleiaQuestaoOrdemPergunta extends Model
{
    public $timestamp = true;

    static public $associations = [
        'assembleia'
    ];

    protected $table = 'assembleia_questoes_ordens_perguntas';

    protected $fillable = [
        'id_assembleia',
        'id_pergunta',
        'motivo',
        'votacao_data_fim',
        'votacao_hora_fim',
        'encerramento_votacao'
    ];

    public function getVotacaoDataFimAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function getVotacaoHoraFimAttribute($value)
    {
        return DataHelper::getPrettyTime($value);
    }

    public function setVotacaoDataFimAttribute($value)
    {
        return $this->attributes['votacao_data_fim'] = DataHelper::setDate($value);
    }


    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class, 'id_assembleia');
    }
}