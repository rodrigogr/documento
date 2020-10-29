<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SituacaoInadimplencia extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idtipo_inadimplencia',
        'descricao',
        'fluxo'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function tipo_inadimplencia()
    {
        return $this->belongsTo('App\Models\TipoInadimplencia', 'idtipo_inadimplencia');
    }
}
