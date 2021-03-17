<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Imovel extends Model
{
    public $timestamp = true;
    protected $table = 'imovel';

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
