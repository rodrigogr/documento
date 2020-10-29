<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class LancamentoAgendar extends Model
{
    public $timestamps = true;
    protected $table = 'lancamento_agendar';

    static public $associations = [
        'tipo_lancamento',
        'parcelas',
        'acrescimos',
        'localidade',
        'empresa',
        'departamento'
    ];

    protected $fillable = [
        'descricao',
        'id_tipo_lancamento',
        'id_tipo_documento',
        'id_fornecedor',
        'mes_competencia',
        'ano_competencia',
        'data_base',
        'valor',
        'numero_nf',
        'data_emissao_nf',
        'id_localizacao',
        'id_departamento',
        'observacao',
        'numero_cheque'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    public function getValorAttribute($value)
    {
        return $value;
    }

    public function setValorAttribute($value)
    {
        return $this->attributes['valor'] = $value;
    }

    public function setDataBaseAttribute($value)
    {
        return $this->attributes['data_base'] = DataHelper::setDate($value);
    }

    public function getDataBaseAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function setDataEmissaoNfAttribute($value)
    {
        return $this->attributes['data_emissao_nf'] = DataHelper::setDate($value);
    }

    public function getDataEmissaoNfAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function tipo_lancamento()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipo_lancamento');
    }

//    public function fornecedor()
//    {
//        return $this->hasOne('App\Models\Empresa','id_empresa');
//    }

    public function parcelas()
    {
        return $this->hasMany('App\Models\ParcelaPagar', 'id_lancamento_agendar');
    }
    public function acrescimos()
    {
        return $this->hasMany('App\Models\AcrescimoPagar', 'id_lancamento_agendar');
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localizacao');
    }

    public function empresa()
    {
        return $this->belongsTo('App\Models\Empresa', 'id_fornecedor');
    }

    public function departamento()
    {
        return $this->belongsTo('App\Models\Departamento', 'id_departamento');
    }
}
