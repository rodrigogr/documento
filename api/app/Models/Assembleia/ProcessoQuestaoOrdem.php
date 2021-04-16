<?php


namespace App\models\Assembleia;


use Illuminate\Database\Eloquent\Model;

class ProcessoQuestaoOrdem extends Model
{
    public $timestamps = true;
    protected $table = 'processos_questao_ordem';
    protected $fillable = ['id_questao_ordem', 'id_thead', 'tipo', 'status'];

    public function thead()
    {
        return $this->hasOne(AssembleiaThead::class, 'id_thead');
    }

    public function questaoOrdem()
    {
        return $this->belongsTo(AssembleiaQuestaoOrdem::class, 'id_questao_ordem');
    }
}