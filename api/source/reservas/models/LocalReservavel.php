<?php
namespace Source\Reservas\Models;

use Illuminate\Database\Eloquent\Model;

class LocalReservavel extends Model
{
    protected $connection = 'portaria';
    protected  $fillable = [
        'local'
    ];
}