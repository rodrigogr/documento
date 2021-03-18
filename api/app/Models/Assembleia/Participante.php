<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class Participante extends Model
{
    public $timestamps = true;

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pessoa()
    {
        return $this->hasOne(Pessoa::class);
    }

    public function imovel()
    {
        return $this->hasOne(Imovel::class);
    }
}
