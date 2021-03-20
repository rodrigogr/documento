<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaOpcao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_opcoes';
    protected $fillable = [
        'opcao'
    ];
    public function assembleiaPergunta()
    {
        return $this->belongsTo(AssembleiaPergunta::class);
    }

    public function assembleiaVotacao()
    {
        return $this->hasOne(AssembleiaVotacao::class);
    }
}