<?php


namespace App\Models\Documentos;


use Illuminate\Database\Eloquent\Model;

class Documento extends Model
{
    public $timestamp = true;
    protected $table = 'documento';

    protected $fillable = [
        'nome',
        'data_envio',
        'url',
        'hash_id',
        'nome_original',
        'categoria_id',
    ];

    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }
}