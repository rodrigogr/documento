<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    public $timestamps = true;

    public function assembleiaThead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }

    public function assembleiaPost()
    {
        return $this->hasOne(AssembleiaPost::class);
    }

    public function assembleiaVotacao()
    {
        return $this->hasOne(AssembleiaVotacao::class);
    }
}
