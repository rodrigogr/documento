<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class Pauta extends Model
{
    public $timestamp = true;

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function assembleiaEncaminhamento()
    {
        return $this->hasOne(AssembleiaEncaminhamento::class);
    }

    public function assembleiaDiscussao()
    {
        return $this->hasOne(AssembleiaDiscussao::class);
    }

    public function assembleiaQuestaoOrdem()
    {
        return $this->hasOne(AssembleiaQuestaoOrdem::class);
    }

    public function assembleiaPergunta()
    {
        return $this->hasOne(AssembleiaPergunta::class);
    }
}