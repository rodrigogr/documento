<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rua extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'descricao',
    ];
}
