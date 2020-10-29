<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GrupoCalculoImovel extends Model
{
    public $timestamps =true;
    protected $table ='grupo_calculo_imoveis';
    protected $fillable = [
        'id_imovel',
        'id_grupo_calculo'
    ];

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasOne ****************************
    public function imoveis()
    {
        return $this->hasOne('App\Models\Imovel','id_imovel');
    }

    public function grupoCalculo()
    {
        return $this->hasOne('App\Models\GrupoCalculo','id_grupo_calculo');
    }
}
