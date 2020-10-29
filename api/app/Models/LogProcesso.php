<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LogProcesso extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'data_inicio_processo',
        'data_fim_processo'
    ];
}
