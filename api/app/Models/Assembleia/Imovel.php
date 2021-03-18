<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class Imovel extends Model
{
    public $timestamp = true;

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
