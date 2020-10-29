<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Feriado extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
        'data',
        'anual',
    ];

    public function setDataAttribute($value)
    {
        return $this->attributes['data'] = DataHelper::setDate($value);
    }

    public function getDataAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
}
