<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Pessoa extends Model
{
    public $timestamp = true;
    protected $table = 'pessoa';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
