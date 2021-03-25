<?php

namespace App\models\Assembleia;

use App\Models\Imovel;
use App\Models\Pessoa;
use Illuminate\Database\Eloquent\Model;

class AssembleiaParticipante extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_participantes';
    protected $fillable = ['id_assembleia','id_imovel', 'id_procurador'];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pessoa()
    {
        return $this->hasOne(Pessoa::class);
    }

    public function imovel()
    {
        return $this->hasOne(Imovel::class);
    }
}
