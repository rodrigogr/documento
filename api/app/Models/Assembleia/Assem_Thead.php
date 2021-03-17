<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assem_Thead extends Model
{
    public $timestamp = true;
    protected $table = 'assem_theads';

    public function assem_anexos()
    {
        return $this->hasMany(Assem_Anexo::class);
    }

    public function assem_posts()
    {
        return $this->hasMany(Assem_Post::class);
    }

    public function assem_encaminhamento()
    {
        return $this->hasOne(Assem_Encaminhamento::class);
    }

    public function assem_discussao()
    {
        return $this->hasOne(Assem_Discussao::class);
    }

    public function assem_questao_ordem()
    {
        return $this->hasOne(Assem_Questao_Ordem::class);
    }

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }
}
