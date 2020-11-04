<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 13/01/17
 * Time: 16:30
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GrupoCalculo extends Model
{
    protected $connection = 'portaria';
    public $timestamps =true;
    protected $table = 'grupo_calculo';
    static public $associations = [
        'formula'
    ];
    protected $fillable = [
        'descricao',
        'id_formula',
        'percentualfundoreserva',
        'id_tipolancamento_taxaassociativa',
        'id_tipolancamento_fundoreserva'
    ];
    
    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasOne ****************************
    public function lancamento_taxaassociativa ()
    {
        return $this->hasOne('App\Models\TipoLancamento', 'id_tipolancamento_taxaassociativa');
    }

    public function lancamento_fundoreserva ()
    {
        return $this->hasOne('App\Models\TipoLancamento', 'id_tipolancamento_fundoreserva');
    }

    public function formula()
    {
        return $this->belongsTo('App\Models\Formula', 'id_formula');
    }
// ************************** belongsTo ****************************
    public function grupo_calculo_imovel()
    {
        return $this->belongsTo('App\Models\GrupoCalculoImovel');
    }
}