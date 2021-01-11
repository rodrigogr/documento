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
}