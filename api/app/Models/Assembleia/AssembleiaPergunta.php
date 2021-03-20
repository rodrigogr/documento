<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaPergunta extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_perguntas';

    protected $fillable = [
        'pergunta'
    ];

    public function assembleiaOpcoes()
    {
        return $this->hasMany(AssembleiaOpcao::class, 'id_pergunta');
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function assembleiaVotacao()
    {
        return $this->hasOne(AssembleiaVotacao::class);
    }
}
