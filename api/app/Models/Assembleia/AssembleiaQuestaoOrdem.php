<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaQuestaoOrdem extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_questoes_ordens';
    protected $fillable = ['id_assembleia','id_pauta','id_thead'];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class, 'id_assembleia');
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function thead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }
}
