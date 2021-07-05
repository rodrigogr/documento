<?php


namespace App\Models\Documentos;


use Illuminate\Database\Eloquent\Model;

class Documento extends Model
{
    public $timestamps = false;
    protected $table = 'documento';

    protected $fillable = [
        'nome',
        'data_postagem',
        'url_documento',
        'hash_id',
        'nome_original_documento',
        'categoria_id',
    ];

    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }
}