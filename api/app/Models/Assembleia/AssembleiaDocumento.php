<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaDocumento extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_documentos';
    protected $fillable = ['file'];

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
