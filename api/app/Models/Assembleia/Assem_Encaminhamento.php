<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assem_Encaminhamento extends Model
{
    public $timestamp = true;
    protected $table = 'assem_encaminhamento';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function assem_thead()
    {
        return $this->hasOne(Assem_Thead::class);
    }
}
