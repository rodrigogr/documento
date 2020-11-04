<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Localidade extends Model
{
    protected $connection = 'portaria';
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'descricao',
        'softdeleted'
    ];

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasOne *******************************
    public function imovel()
    {
        return $this->hasOne('App\Models\Imovel', 'idlocalidade');
    }

    public function lancamento_agendar()
    {
        return $this->hasOne('App\Models\LancamentoAgendar', 'id_localizacao');
    }
}
