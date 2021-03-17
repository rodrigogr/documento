<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assem_Discussao extends Model
{
    public $timestamps = true;
    protected $table = 'assem_discussao';

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
