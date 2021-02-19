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


    // ************************** hasMany ******************************
    
    public function imoveis_permanentes()
    {
        return $this->hasMany('App\Models\ImovelPermanente', 'id_imovel');
    }
}
