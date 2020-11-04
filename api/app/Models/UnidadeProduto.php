<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UnidadeProduto extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
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
