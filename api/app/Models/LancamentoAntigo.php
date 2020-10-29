<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class LancamentoAntigo extends Model
{
    public $timestamps = true;
    use SoftDeletes;

    static public $associations = [
        'carteira',
        'layout_remessa',
        'imovel',
        'empresa',
        'lancamentos'
    ];

    protected $dates = ['deleted_at'];

    protected $fillable = [
        'id_configuracao_carteira',
        'id_layout_remessa',
        'idimovel',
        'id_empresa',
        'data_vencimento',
        'descricao',
        'observacao',
        'cancelamento',
        'motivo_cancelamento',
        'tipo_cobranca',
        'valor'
    ];

    public function setDataVencimentoAttribute($value){
        return $this->attributes['data_vencimento'] = DataHelper::setDate($value);
    }

    public function getDataVencimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
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

    public function lancamentos()
    {
        return $this->belongsToMany('App\Models\Lancamento', 'lancamento_antigo_lancamentos','id_lancamento_antigo','id_lancamento');
    }

}
