<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContasReceber extends Model
{
    use SoftDeletes;
    protected  $table = 'contas_receber';
    protected $fillable = [
        'valor_total',
        'total_abatimento',
        'total_antecipado',
        'total_recebido',
        'total_provisionado',
        'saldo_receber',
        'data_agendamento',
        'id_imovel',
        'id_empresa',
        'valor_juros',
        'valor_multa',
        'valor_original'
    ];
    protected $dates = ['deleted_at'];
    public $timestamps = true;

    public function setDataAgendamentoAttribute($value)
    {
        return $this->attributes['data_agendamento'] = DataHelper::setDate($value);
    }

    public function getDataAgendamentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }
    
    public function empresa()
    {
        return $this->belongsTo('App\Models\Empresa', 'id_empresa');
    }

    public function lancamentos()
    {
        return $this->belongsToMany('App\Models\Lancamento', 'lancamentos_contas_receber','id_conta_receber','id_lancamento')->withPivot('id');
    }

    public function register(array $attributes = [])
    {
        $conta_receber = new  ContasReceber();
        $conta_receber->valor_total = $request['valor'];
        $conta_receber->total_provisionado = $request['valor'];
        $conta_receber->data_agendamento = DataHelper::setDate($request['data_agendamento']);
        $conta_receber->id_imovel = $request['idimovel'];
        $conta_receber->save();
    }
}
