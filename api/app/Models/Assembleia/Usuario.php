<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    public $timestamps = true;
    protected $table = 'usuario';

    public function assem_thead()
    {
        return $this->hasOne(Assem_Thead::class);
    }

    public function assem_post()
    {
        return $this->hasOne(Assem_Post::class);
    }

    public function assembleia_votacao()
    {
        return $this->hasOne(Assembleia_Votacao::class);
    }
}
