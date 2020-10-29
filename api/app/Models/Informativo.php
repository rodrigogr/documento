<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Informativo extends Model
{
    public $timestamps = true;
    protected $table = 'informativo';

    protected $fillable = [
        'tipo',
        'conteudo',
        'datainicial',
        'datafinal',
        'image'
    ];


    public function setDataInicialAttribute($value)
    {
        return $this->attributes['datainicial'] = DataHelper::setDate($value);
    }

    public function getDataInicialAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
        // return $value;
    }

    public function setDataFinalAttribute($value)
    {
        return $this->attributes['datafinal'] = DataHelper::setDate($value);
    }

    public function getDataFinalAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
        // return $value;
    }
}
