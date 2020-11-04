<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 24/01/17
 * Time: 10:37
 */

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Formula extends  Model
{
    public $timestamps = true;
    protected $connection = 'portaria';
    protected $fillable = [
        'formula'
    ];


}