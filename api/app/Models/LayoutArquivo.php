<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LayoutArquivo extends Model
{

    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
        'arquivo'
    ];
    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ****************************
    public function recebimentos()
    {
        return $this->hasMany('App\Models\Recebimentos', 'idlayout_arquivo');
    }
}

