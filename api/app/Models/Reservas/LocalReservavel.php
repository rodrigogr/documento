<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class LocalReservavel extends Model
{
    protected $connection = 'portal';
    protected $table = 'local_reservavel';
    protected $fillable = [
        'id_localidade',
        'nome',
        'descricao',
    ];

    public static function complete()
    {
        return self::with('localidade')->get();
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localidade');
    }
}