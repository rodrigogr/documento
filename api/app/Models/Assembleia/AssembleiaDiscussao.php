<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaDiscussao extends Model
{
    public $timestamps = true;

    static public $associations = [
        'pauta ',
        'theads'
    ];

    protected $table = 'assembleia_dicussoes';
    protected $fillable = ['id_assembleia', 'id_pauta', 'id_thead'];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class,'id_assembleia');
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class, 'id');
    }

    public function theads()
    {
        return $this->hasOne(AssembleiaThead::class);
    }
}
