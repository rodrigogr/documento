<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaQuestaoOrdem extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_questoes_ordens';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function assembleiaThead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }
}
