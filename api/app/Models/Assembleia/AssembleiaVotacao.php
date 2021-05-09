<?php

namespace App\models\Assembleia;

use Illuminate\Database\Eloquent\Model;

class AssembleiaVotacao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_votacoes';
    protected $fillable = [
        'id_assembleia',
        'id_pergunta',
        'id_opcao',
        'id_pessoa',
        'id_imovel',
        'ip',
        'mac_address',
        'peso'
    ];

    public function usuario()
    {
        return $this->hasOne(Usuario::class);
    }

    public function assembleiaPergunta()
    {
        return $this->hasOne(AssembleiaPergunta::class);
    }

    public function assembleiaOpcao()
    {
        return $this->hasOne(AssembleiaOpcao::class);
    }
}
