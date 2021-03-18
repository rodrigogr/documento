<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaPost extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_posts';

    public function assembleiaThead()
    {
        return $this->belongsTo(AssembleiaThead::class);
    }

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }
}
