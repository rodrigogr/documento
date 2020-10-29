<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuitacaoDocumento extends Model
{
    public $timestamps = true;

    protected $fillable = [
        'titulo',
        'conteudo'
    ];
}
