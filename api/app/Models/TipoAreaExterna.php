<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipoAreaExterna extends Model
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
    public function area_externa()
    {
        return $this->hasMany('App\Models\AreaExterna', 'idtipo_area_externa');
    }
}
