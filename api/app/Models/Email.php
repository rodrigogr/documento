<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Email extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'idcontato',
        'email',
        'notificacao'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function contato()
    {
        return $this->belongsTo('App\Models\Pessoa', 'idcontato');
    }


}
