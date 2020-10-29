<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rua extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
    ];
}
