<?php

namespace App\models\assembleia;

use Illuminate\Database\Eloquent\Model;

class Assembleia_Documento extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_documento';
    protected $fillable = ['file'];
    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
