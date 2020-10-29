<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Movimentacao extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'iddepositante',
        'iddepositario',
        'data',
        'valor'
    ];

    // ************************** belongsTo ****************************
    public function depositante()
    {
        return $this->belongsTo('App\Models\ContaBancaria', 'iddepositante');
    }

    public function depositario()
    {
        return $this->belongsTo('App\Models\ContaBancaria', 'iddepositario');
    }
}
