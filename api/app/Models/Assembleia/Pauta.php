<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Pauta extends Model
{
    public $timestamp = true;
    protected $table = 'pauta';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function assem_encaminhamento()
    {
        return $this->hasOne(Assem_Encaminhamento::class);
    }

    public function assem_discussao()
    {
        return $this->hasOne(Assem_Discussao::class);
    }

    public function assem_questao_ordem()
    {
        return $this->hasOne(Assem_Questao_Ordem::class);
    }

    public function assembleia_pergunta()
    {
        return $this->hasOne(Assembleia_Pergunta::class);
    }
}