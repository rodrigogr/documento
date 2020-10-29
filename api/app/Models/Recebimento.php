<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Recebimento extends Model
{
    use SoftDeletes;
    public $timestamps = true;
    static public $associations = [
        'lancamentos',
        'carteira',
        'layout_remessa',
        'imovel',
        'associado',
        'empresa',
        'parcelas'
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];
    protected $fillable = [
        'id_configuracao_carteira',
        'id_layout_remessa',
        'idimovel',
        'idassociado',
        'id_empresa',
        'forma_pagamento',
        'data_agendamento',
        'valor_adicional',
        'descricao_acrescimo',
        'numero_parcelas',
        'valor_abatimento',
        'data_recebimento',
        'numero_comprovante'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function setDataAgendamentoAttribute($value)
    {
        return $this->attributes['data_agendamento'] = DataHelper::setDate($value);
    }

    public function getDataAgendamentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsToMany ****************************
    public function lancamentos()
    {
        return $this->belongsToMany('App\Models\LancamentosContaReceber', 'recebimento_lancamentos','id_recebimento','id_lancamento_receber');
    }
    // ************************** belongsTo ****************************

//    public function conta_bancaria()
//    {
//        return $this->belongsTo('App\Models\ContaBancaria', 'idconta_bancaria');
//    }

    public function carteira()
    {
        return $this->belongsTo('App\Models\ConfiguracaoCarteira', 'id_configuracao_carteira');
    }

    public function layout_remessa()
    {
        return $this->belongsTo('App\Models\LayoutRemessa', 'id_layout_remessa');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'idimovel');
    }

    public function associado()
    {
        return $this->belongsTo('App\Models\Pessoa', 'idassociado');
    }

    public function empresa()
    {
        return $this->belongsTo('App\Models\Empresa', 'id_empresa');
    }

    public function parcelas()
    {
        return $this->hasMany('App\Models\RecebimentoParcela','id_recebimento');
    }

    public function acordo()
    {
        return $this->hasMany('App\Models\Acordo','id_recebimento','id');
    }
}
