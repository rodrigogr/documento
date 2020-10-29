<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AcordoParcelasNegociadas extends Model
{
    public $timestamps = true;
    protected  $table = 'acordo_parcelas_negociadas';

    protected $fillable = [
        'id_acordo',
        'id_parcela_negociada'
    ];
    public function recebimento_parcela()
    {
        return $this->hasOne('App\Models\RecebimentoParcela','id','id_parcela_negociada');
    }
    public function parcela_boleto()
    {
        return $this->hasOne('App\Models\ParcelaBoleto','id_parcela','id_parcela_negociada');
    }
}
