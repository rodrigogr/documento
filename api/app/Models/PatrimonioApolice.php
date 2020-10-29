<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PatrimonioApolice extends Model
{
    public $timestamps = false;
    protected $table = 'patrimonios_apolices' ;

    public function patrimonios()
    {
        return $this->belongsToMany('App\Models\PatrimonioBem',
            'patrimonios_apolices_patrimonios', 'id_apolice', 'id_patrimonio');
    }

    public function seguradora()
    {
        return $this->belongsTo('App\Models\Empresa', 'id_empresa');
    }
}
