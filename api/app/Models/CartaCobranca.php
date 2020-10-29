<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CartaCobranca extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'titulo',
        'conteudo'
    ];
}
