<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaEncaminhamento extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_encaminhamentos';

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
