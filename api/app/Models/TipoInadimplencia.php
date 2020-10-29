<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoInadimplencia extends Model
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
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function situacao_inadimplencias()
    {
        return $this->hasMany('App\Models\SituacaoInadimplencia', 'idtipo_inadimplencia');
    }
}
