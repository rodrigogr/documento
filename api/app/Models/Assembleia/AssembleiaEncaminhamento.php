<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaEncaminhamento extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_encaminhamentos';
    protected $fillable = ['id_assembleia','id_pauta','id_thead','status', 'apoio'];


    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pauta()
    {
        return $this->hasOne(Pauta::class);
    }

    public function thead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }

    /*public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }*/
}
