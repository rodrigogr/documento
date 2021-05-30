<?php


namespace App\Models\Assembleia;


use Illuminate\Database\Eloquent\Model;

class AssembleiaQuestaoOrdemVotacao extends Model
{
    public $timestamps = true;
    protected $table = 'assembleia_questoes_ordens_votacoes';
    protected $fillable = [
        'id_assembleia',
        'id_pergunta',
        'id_opcao',
        'id_pessoa',
        'imovel',
        'peso_voto',
        'ip',
        'mac_address',
        'peso'
    ];

    public function pessoa()
    {
        return $this->hasOne(Pessoa::class);
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