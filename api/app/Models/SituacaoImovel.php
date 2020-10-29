<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class SituacaoImovel extends Model
{
    public $timestamps = true;
    protected $table = 'situacao_imoveis';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
        'percentual_desconto',
        'softdeleted'
    ];

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ******************************
    public function imoveis()
    {
        return $this->hasOne('App\Models\Imovel', 'idsituacao_imovel');
    }

    public function getPercentualDescontoAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setPercentualDescontoAttribute($value)
    {
        return $this->attributes['percentual_desconto'] = DataHelper::getReal2Float($value);
    }
}

