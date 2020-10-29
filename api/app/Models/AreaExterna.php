<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;

class AreaExterna extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'idtipo_area_externa',
        'idimovel',
        'quantidade',
        'area_construida'
    ];

    public function getAreaConstruidaAttribute($value)
    {
        return DataHelper::getFloat2Real($value);
    }

    public function setAreaConstruidaAttribute($value)
    {
        return $this->attributes['area_construida'] = DataHelper::getReal2Float($value);
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function tipo_area_externa()
    {
        return $this->belongsTo('App\Models\TipoAreaExterna', 'idtipo_area_externa');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'idimovel');
    }


}
