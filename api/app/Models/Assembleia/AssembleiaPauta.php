<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaPauta extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_pautas';

    static public $associations = [
        'assembleiaPergunta '
    ];

    protected $fillable = [
        'id_assembleia',
        'id_pergunta'
    ];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class, 'id_assembleia');
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

    public function assembleiaPergunta()
    {
        return $this->belongsTo(AssembleiaPergunta::class, 'id');
    }
}