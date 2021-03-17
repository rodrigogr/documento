<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assem_Anexo extends Model
{
    public $timestamp = true;
    protected $table = 'assem_anexo';

    public function assem_thead()
    {
        return $this->belongsTo(Assem_Thead::class);
    }
}
