<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Helpers\DataHelper;

class Acordo extends Model
{
    public $timestamps = true;

    static public $associations = [
        'recebimento_parcelas',
        'parcelas_negociadas',
        'recebimento_acordo'
    ];

    protected $fillable = [
        'id_recebimento',
        'id_associado',
        'id_empresa',
        'nome_parceiro',
        'data_acordo',
        'data_agendamento',
        'valor_divida',
        'valor_acordo',
        'multa',
        'juros',
        'correcoes',
        'valor_adicional',
        'descricao_acrescimo',
        'valor_entrada',
        'data_recebimento_entrada',
        'comprovante_entrada',
    ];

    static public function complete($id)
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

    public function setDataAcordoAttribute($value)
    {
        return $this->attributes['data_acordo'] = DataHelper::setDate($value);
    }
    public function getDataAcordoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function recebimento_acordo()
    {
        return $this->belongsTo('App\Models\Recebimento','id_recebimento','id');
    }
    public function recebimento_parcelas()
    {
        return $this->hasMany('App\Models\RecebimentoParcela','id_recebimento','id_recebimento');
    }
    public function parcelas_negociadas()
    {
        return $this->hasMany('App\Models\AcordoParcelasNegociadas','id_acordo');
    }
}
