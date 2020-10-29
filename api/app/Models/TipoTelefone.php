<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoTelefone extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao'
    ];

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ******************************
    public function telefones()
    {
        return $this->hasMany('App\Models\Telefone', 'idtipo_telefone');
    }
}
