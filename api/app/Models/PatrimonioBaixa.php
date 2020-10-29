<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PatrimonioBaixa extends Model
{
    public $timestamps = false;
    protected $table = 'patrimonios_baixas';

    public function patrimonio()
    {
        return $this->belongsTo('App\Models\PatrimonioBem', 'id_patrimonio');
     }
}
