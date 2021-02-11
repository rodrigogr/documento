<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;

class DiaInativoLocalReservavel extends Model
{
    protected $table = 'dia_inativo_local_reservavel';
    public $timestamps = false;
    protected $fillable = [
        'id_local_reservavel',
        'data',
        'descricao',
        'repetir'
    ];

}