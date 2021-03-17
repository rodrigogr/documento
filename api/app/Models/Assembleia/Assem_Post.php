<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assem_Post extends Model
{
    public $timestamp = true;
    protected $table = 'assem_post';

    public function assem_thead()
    {
        return $this->belongsTo(Assem_Thead::class);
    }

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }
}
