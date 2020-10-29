<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Carteira extends Model
{
    public $timestamps = true;
    protected $fillable = [
        'descricao',
        'id_banco'
    ];
    static public $associations = ['configuracao_carteira'];
    public function configuracao_carteira()
    {
        return $this->hasOne('App\Models\ConfiguracaoCarteira', 'id_carteira');
    }
}
