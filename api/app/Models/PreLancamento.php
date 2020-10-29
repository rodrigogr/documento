<?php

namespace App\Models;
use Illuminate\Database\Eloquent\SoftDeletes;

class PreLancamento extends Lancamento
{
//    use SoftDeletes;
    static public $associations = [
        'imovel',
        'lancamento'
    ];
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $primaryKey = 'id_lancamento';
//    protected $dates = ['deleted_at'];
    protected $fillable = [
        'id_lancamento',
        'idimovel',
        'observacao',
        'valor_desconto',//** Campo não utilizado. */
        'descricao_desconto',//** Campo não utilizado. */
        'mes',
        'ano',
        'valor_percentual'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id_lancamento', $id)->with(self::$associations)->first() : self::orderBy('id_lancamento','DESC')->with(self::$associations)->get();
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'idimovel');
    }

    // ************************** hasOne ****************************
    public function lancamento()
    {
        return $this->hasOne('App\Models\Lancamento','id', 'id_lancamento');
    }
}
