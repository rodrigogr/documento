<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LancamentoAntigoLancamento extends Model
{
    public $timestamps = true;
    protected $fillable = [
        'id_lancamento_antigo',
        'id_lancamento'
    ];
}
