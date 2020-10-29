<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfiguracaoCarteira extends Model
{
    public $timestamps = true;
    static public $associations = [
        'conta_bancaria',
        'carteira',
        'layout_remessa',
        'layout_retorno'
    ];
    protected $fillable = [
        'id_conta_bancaria',
        'id_carteira',
        'id_layout_remessa',
        'id_layout_retorno',
        'agencia',
        'conta_corrente',
        'codigo_cedente',
        'primeiro_dado_config',
        'segundo_dado_config',
        'instru_cobranca_um',
        'instru_cobranca_dois',
        'instru_cobranca_tres',
        'nosso_numero_inicio',
        'nosso_numero_fim'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }
    public function conta_bancaria()
    {
        return $this->belongsTo('App\Models\ContaBancaria','id_conta_bancaria');
    }

    public function carteira()
    {
        return $this->belongsTo('App\Models\Carteira','id_carteira');
    }

    public function layout_remessa()
    {
        return $this->belongsTo('App\Models\LayoutRemessa','id_layout_remessa');
    }

    public function layout_retorno()
    {
        return $this->belongsTo('App\Models\LayoutRetorno','id_layout_retorno');
    }

}
