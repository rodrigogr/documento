<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia_Votacao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_votacao';

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }

    public function assembleia_pergunta()
    {
        return $this->hasOne(Assembleia_Pergunta::class);
    }

    public function assembleia_opcao()
    {
        return $this->hasOne(Assembleia_Opcao::class);
    }
}
