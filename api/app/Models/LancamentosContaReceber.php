<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LancamentosContaReceber extends Model
{
    protected $table = 'lancamentos_contas_receber';

    protected $fillable = [
        'id_conta_receber',
        'id_lancamento'
    ];
    public $timestamps = true;

    public function lancamento()
    {
        return $this->belongsTo('App\Models\Lancamento','id_lancamento');
    }

    public function conta_receber()
    {
        return $this->belongsTo('App\Models\ContasReceber','id_conta_receber');
    }

    /*public function recebimentos()
    {
        return $this->belongsTo('App\Models\Recebimento');
    }*/

    public function lancamentos_recebimento()
    {
        return $this->belongsToMany('App\Models\Recebimento','recebimento_lancamentos','id','id_lancamento_receber');
    }
}
