<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia_Pergunta extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_pergunta';

    public function assembleia_opcoes()
    {
        return $this->hasMany(Assembleia_Opcao::class);
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function assembleia_votacao()
    {
        return $this->hasOne(Assembleia_Votacao::class);
    }
}
