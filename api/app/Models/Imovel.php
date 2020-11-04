<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Imovel extends Model
{
    public $timestamps = true;
    protected $table = 'imovel';
    protected $connection = 'portaria';
    protected $fillable = [
        'quadra',
        'lote',
        'logradouro',
        'area_imovel',
        'obs',
        'numero',
        'id_pessoa_proprietario',
        'cep',
        'idinquilino',
        'idlocalidade',
        'idsituacao_imovel',
        'area_construida',
        'area_ajardinada',
        'softdeleted',
        'base_calculo',
        'imovel_ficticio'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with('imoveis_permanentes')->first() : self::with('imoveis_permanentes')->get();
    }

    static public function getTotalImovelAtivoNaoFicticio()
    {
        return Imovel::all()->where('imovel_ficticio', '=', '0')->count();
    }

    static public function getAreaTotalCondominio()
    {
        return Imovel::all()->where('imovel_ficticio', '=', '0')->sum('base_calculo');
    }
    
    public function getAreaImovelAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setAreaImovelAttribute($value)
    {
        return $this->attributes['area_imovel'] = DataHelper::getReal2Float($value);
    }

    public function getAreaConstruidaAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setAreaConstruidaAttribute($value)
    {
        return $this->attributes['area_construida'] = DataHelper::getReal2Float($value);
    }

    public function getAreaAjardinadaAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setAreaAjardinadaAttribute($value)
    {
        return $this->attributes['area_ajardinada'] = DataHelper::getReal2Float($value);
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'idlocalidade');
    }

    public function situacao_imovel()
    {
        return $this->belongsTo('App\Models\SituacaoImovel', 'idsituacao_imovel');
    }

    public function grupo_calculo_imovel()
    {
        return$this->belongsTo('App\Models\GrupoCalculoImovel');
    }
    // ************************** hasMany ******************************
    public function areas_externas()
    {
        return $this->hasMany('App\Models\AreaExterna', 'idimovel');
    }

    public function documentos()
    {
        return $this->hasMany('App\Models\AreaExterna', 'idimovel');
    }

    public function imoveis_permanentes()
    {
        return $this->hasMany('App\Models\ImovelPermanente', 'id_imovel');
    }

    public function pre_lancamentos()
    {
        return $this->hasMany('App\Models\PreLancamento', 'idimovel');
    }

    public function receita_calculo_fundo()
    {
        return $this->hasMany('App\Models\ReceitaCalculoFundo', 'id_imovel');
    }

    public function receita_calculo_taxa()
    {
        return $this->hasMany('App\Models\ReceitaCalculoTaxa','id_imovel');
    }

    public function contas_receber()
    {
        return $this->hasMany('App\Models\ContasReceber', 'id_imovel');
    }
}
