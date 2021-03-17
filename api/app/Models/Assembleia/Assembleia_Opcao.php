<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia_Opcao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_opcao';

    public function assembleia_pergunta()
    {
        return $this->belongsTo(Assembleia_Pergunta::class);
    }

    public function assembleia_votacao()
    {
        return $this->hasOne(Assembleia_Votacao::class);
    }
}
