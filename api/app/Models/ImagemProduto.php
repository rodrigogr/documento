<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ImagemProduto extends Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'idprodutos',
        'imagem'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function produto()
    {
        return $this->belongsTo('App\Models\Produto', 'idprodutos');
    }
}
