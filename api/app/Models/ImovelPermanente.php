<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class ImovelPermanente extends Model
{
    public $timestamps = true;
    protected $table = 'imovel_permanente';
    protected $connection = 'portaria';
    protected $fillable = [
        'id_pessoa',
        'id_imovel',
        'imovel_principal',
        'data_insercao',
        'data_exclusao',
        'excluido',
        'data_mudanca',
        'titular_imovel',
        'pessoa_titular'
    ];

    public static function getTitularImovel($id_imovel)
    {
       $result = ImovelPermanente::select('id_pessoa')->where('id_imovel','=',$id_imovel,'AND')
           ->where('pessoa_titular','=',true)->where('excluido','=','n')->get();
        return $result;
    }

    public function setDataMudancaAttribute($value)
    {
        return $this->attributes['data_mudanca'] = DataHelper::setDate($value);
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************

    public function getDataMudancaAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function pessoa()
    {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }
}