<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class ContaBancaria extends Model 
{
    protected $connection = 'portaria';
    public $timestamps = true;
    static public $associations = [
        'banco',
        'configuracao_carteira'
    ];

    protected $fillable = [
        'idbanco',
        'agencia',
        'conta',
        'tipo',
        'operacao',
        'relatorio',
        'descricao',
        'tipo_banco',
        'saldo',
        'data_saldo_inicial'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }
    public function setDataSaldoInicialAttribute($value)
    {
        return $this->attributes['data_saldo_inicial'] = DataHelper::setDate($value);
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function banco()
    {
        return $this->belongsTo('App\Models\Banco', 'idbanco');
    }

    // ************************** hasMany ****************************
    public function transferencia_recebidas()
    {
        return $this->hasMany('App\Models\Transferencias', 'iddepositario');
    }

    public function transferencia_enviadas()
    {
        return $this->hasMany('App\Models\Transferencias', 'iddepositante');
    }

    public function movimentacoes_recebidas()
    {
        return $this->hasMany('App\Models\Movimentacao', 'iddepositario');
    }

    public function movimentacoes_enviadas()
    {
        return $this->hasMany('App\Models\Movimentacao', 'iddepositante');
    }

    public function configuracao_carteira ()
    {
        return $this->hasMany('App\Models\ConfiguracaoCarteira', 'id_conta_bancaria');
    }
}
