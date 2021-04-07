<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssembleiaDocumento extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_documentos';
    protected $fillable = ['file'];
    use SoftDeletes;

    public function assembleia()
    {
        return $this->belongsTo(Assembleia::class);
    }
}
