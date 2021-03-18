<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaAnexo extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_anexos';

    public function assembleiaThead()
    {
        return $this->belongsTo(AssembleiaThead::class);
    }
}
