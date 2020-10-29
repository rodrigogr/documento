<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GrupoProduto extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
        'depreciacao',
        'status'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ****************************
    public function produtos()
    {
        return $this->hasMany('App\Models\Produto', 'idgrupo_produto');
    }
}
