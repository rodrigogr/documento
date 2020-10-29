<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GrupoLancamento extends Model
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
    // ************************** hasMany ****************************
    public function tipo_lancamentos()
    {
        return $this->hasMany('App\Models\TipoLancamento', 'idgrupo_lancamento');
    }
}
