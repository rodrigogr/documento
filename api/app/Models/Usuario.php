<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    protected $connection = 'portaria';
    protected $table = 'usuario';
    public $timestamps = true;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_pessoa_funcionario',
        'senha',
        'id_categoria',
        'ativo',
        'ultima_atualizacao',
        'login'
    ];

    public function pessoa() {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa_funcionario');
    }

}
