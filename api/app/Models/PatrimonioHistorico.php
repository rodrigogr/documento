<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PatrimonioHistorico extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'id_patrimonio', 'status', 'id_usuario', 'data_hora'
    ];
    protected $table = 'patrimonios_historicos' ;

    public function patrimonio()
    {
        return $this->belongsTo('App\Models\PatrimonioBem', 'id_patrimonio');
    }

    public function usuario()
    {
        return $this->belongsTo('App\Models\Usuario', 'id_usuario');
    }
}
