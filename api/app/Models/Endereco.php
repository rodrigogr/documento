<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Endereco extends Model
{
    public $timestamps = false;
    protected $table = 'endereco';


    protected $fillable = [
        'endereco',
        'cidade',
        'uf',
        'cep',
        'complemento',
        'bairro'
    ];

}
