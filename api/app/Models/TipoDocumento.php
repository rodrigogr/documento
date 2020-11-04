<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoDocumento extends Model
{
    protected $connection = 'portaria';
    public $timestamps = true;

    protected $fillable = [
        'id',
        'nome'
    ];
}
