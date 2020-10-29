<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class Telefone extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idcontato',
        'idtipo_telefone',
        'numero'
    ];

    public function setNumeroAttribute($value)
    {
        return $this->attributes['numero'] = DataHelper::getOnlyNumbers($value);
    }

    public function getNumeroAttribute($value)
    {
        return DataHelper::mask($value, '(##)#####-####');
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function contato()
    {
        return $this->belongsTo('App\Models\Pessoa', 'idcontato');
    }

    public function tipo_telefone()
    {
        return $this->belongsTo('App\Models\TipoTelefone', 'idtipo_telefone');
    }

}
