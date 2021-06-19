<?php


namespace App\Models\Documentos;


use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    public $timestamp = true;
    protected $table = 'documento_categorias';

    protected $fillable = [
        'nome'
    ];

    public function documentos()
    {
        return $this->hasMany(Documento::class);
    }
}