<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaVotacao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_votacoes';

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }

    public function assembleiaPergunta()
    {
        return $this->hasOne(AssembleiaPergunta::class);
    }

    public function assembleiaOpcao()
    {
        return $this->hasOne(AssembleiaOpcao::class);
    }
}