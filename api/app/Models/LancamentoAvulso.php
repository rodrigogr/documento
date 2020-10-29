<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;


class LancamentoAvulso extends Lancamento
{
    static public $associations = [
        'carteira',
        'layout_remessa',
        'imovel',
        'empresa',
        'lancamento'
    ];
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $primaryKey = 'id_lancamento';
    protected $fillable = [
        'id_lancamento',
        'id_configuracao_carteira',
        'id_layout_remessa',
        'idimovel',
        'id_empresa',
        'data_vencimento',
        'observacao',
        'cancelamento',
        'motivo_cancelamento'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id_lancamento', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function getValorAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setValorAttribute($value)
    {
        return $this->attributes['valor'] = DataHelper::getReal2Float($value);
    }

    public function setDataVencimentoAttribute($value)
    {
        return $this->attributes['data_vencimento'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************

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

    public function empresa()
    {
        return $this->belongsTo('App\Models\Empresa', 'id_empresa');
    }

    // ************************** hasOne ****************************
    public function lancamento()
    {
        return $this->hasOne('App\Models\Lancamento', 'id');
    }


}
