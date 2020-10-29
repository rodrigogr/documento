<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class LancamentoRecorrente extends Lancamento
{
    static public $associations = [
        'localidade',
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
        'idlocalidade',
        'tipo_associacao',
        'data_ini',
        'data_fim',
        'rateio',
        'fixo'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id_lancamento', $id)->with(self::$associations)->first() : self::orderBy('id_lancamento','DESC')->with(self::$associations)->get();
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'idlocalidade');
    }

    // ************************** hasOne ****************************
    public function lancamento()
    {
        return $this->hasOne('App\Models\Lancamento','id');
    }
}
