<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LayoutRemessa extends Model
{
    public $timestamps = true;
    protected $fillable = [
        'descricao'
    ];
    static public $associations = ['configuracao_carteira'];
    public function configuracao_carteira()
    {
        return $this->hasOne('App\Models\ConfiguracaoCarteira', 'id_layout_remessa');
    }
}
