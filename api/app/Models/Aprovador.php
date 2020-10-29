<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Aprovador extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idusuario',
        'email',
        'tipo'
    ];
}
