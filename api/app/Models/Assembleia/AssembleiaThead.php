<?php

namespace App\models\Assembleia;

use App\Models\Pessoa;
use Illuminate\Database\Eloquent\Model;

class AssembleiaThead extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_theads';

    static public $associations = [
        'posts '
    ];
    protected $fillable = [
        'titulo',
        'texto',
        'id_pessoa'
    ];

    public function theadAnexos()
    {
        return $this->hasMany(TheadAnexo::class, 'id_thead');
    }

    public function posts()
    {
        return $this->hasMany(AssembleiaPost::class, 'id_thead');
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

    public function Pessoa()
    {
        return $this->hasOne(Pessoa::class, 'id_pessoa');
    }

    public function processosQuestaoOrdem()
    {
        return $this->hasOne(ProcessoQuestaoOrdem::class);
    }

}
