<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaThead extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_theads';

    public function assembleiaAnexos()
    {
        return $this->hasMany(AssembleiaAnexo::class);
    }

    public function assembleiaPosts()
    {
        return $this->hasMany(AssembleiaPost::class);
    }

    public function assembleiaEncaminhamento()
    {
        return $this->hasOne(AssembleiaEncaminhamento::class);
    }

    public function assembleiaDiscussao()
    {
        return $this->hasOne(AssembleiaDiscussao::class);
    }

    public function assembleiaQuestaoOrdem()
    {
        return $this->hasOne(AssembleiaQuestaoOrdem::class);
    }

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }
}
