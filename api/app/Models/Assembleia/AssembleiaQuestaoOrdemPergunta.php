<?php


namespace App\Models\Assembleia;


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



    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class, 'id_assembleia');
    }
}