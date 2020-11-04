<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Banco extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'codigo',
        'descricao',
        'url',
        'img'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ****************************
    public function conta_bancarias()
    {
        return $this->hasMany('App\Models\ContaBancaria', 'idbanco');
    }
}
