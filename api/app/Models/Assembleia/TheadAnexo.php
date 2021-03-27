<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class TheadAnexo extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_theads_anexos';
    protected $fillable = ['id_thead', 'file'];

    public function assembleiaThead()
    {
        return $this->belongsTo(AssembleiaThead::class);
    }
}
