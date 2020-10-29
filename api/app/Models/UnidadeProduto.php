<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UnidadeProduto extends Model
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
    // ************************** hasMany ****************************
    public function produtos()
    {
        return $this->hasMany('App\Models\Produto', 'idunidade_produto');
    }
}
