<?php

namespace App\models\Assembleia;

use App\Helpers\DataHelper;
use App\Models\Pessoa;
use Illuminate\Database\Eloquent\Model;

class AssembleiaEncaminhamento extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_encaminhamentos';
    protected $attributes = ['status'=>'pendente', 'apoio'=>0];
    protected $fillable = ['id_assembleia','id_pauta','id_thead', 'status'];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }

    public function pauta()
    {
        return $this->hasOne(AssembleiaPauta::class);
    }

    public function thead()
    {
        return $this->hasOne(AssembleiaThead::class);
    }

    public function getDataHoraAttribute($value)
    {
        return DataHelper::getPrettyDateTime($value);
    }
}