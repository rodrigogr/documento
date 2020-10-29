<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SendEmail extends Model
{
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_pessoa',
        'email_enviado',
        'status'
    ];
}
