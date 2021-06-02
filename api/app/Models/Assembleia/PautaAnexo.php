<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class PautaAnexo extends Model
{
    public $timestamp = true;
    protected $table = 'assembleia_pautas_anexos';
    protected $fillable = ['id_pauta', 'file', 'name'];

    public function assembleiaPauta()
    {
        return $this->belongsTo(AssembleiaPauta::class);
    }
}
