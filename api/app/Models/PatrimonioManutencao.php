<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PatrimonioManutencao extends Model
{
    public $timestamps = false;
    protected $table = 'patrimonios_manutencoes';

    public function patrimonio()
    {
        return $this->belongsTo('App\Models\PatrimonioBem', 'id_patrimonio');
    }

    public function fornecedor()
    {
         return $this->belongsTo('App\Models\Empresa', 'id_empresa');
    }
}
