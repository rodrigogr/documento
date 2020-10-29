<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoDocumento extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'id',
        'nome'
    ];
}
