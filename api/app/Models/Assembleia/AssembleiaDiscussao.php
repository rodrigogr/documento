<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaDiscussao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_discussoes';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function assembleiathead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }
}
