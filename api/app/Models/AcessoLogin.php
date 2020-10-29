<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AcessoLogin extends Model
{
    protected $table = 'acesso_login';
    public $timestamps = true;

    protected $fillable = [
        'hash',
        'id_pessoa',
        'ativo'
    ];
}
