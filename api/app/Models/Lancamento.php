<?php

namespace App\Models;

use App\Helpers\DataHelper;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Lancamento extends Model
{
    use SoftDeletes;
    static public $associations = [
        'pre_lancamento ',
        'lancamento_avulso',
        'lancamento_recorrente',
        'lancamento_taxa',
        'lancamento_fundo'
    ];
    public $timestamps = true;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];
    protected $fillable = [
        'valor',
        'descricao',
        'idtipo_lancamento',
        'saldo_receber',
        'categoria'
    ];

    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** hasMany ****************************
    public function conta_receber()
    {
        return $this->belongsToMany('App\Models\ContasReceber', 'lancamentos_contas_receber','id_lancamento','id_conta_receber')->withPivot('id');
    }

    public function pre_lancamento()
    {
        return $this->belongsTo('App\Models\Prelancamento', 'id_lancamento');
    }

    public function lancamento_avulso()
    {
        return $this->belongsTo('App\Models\LancamentoAvulso', 'id_lancamento');
    }

    public function lancamento_recorrente()
    {
        return $this->belongsTo('App\Models\LancamentoRecorrente', 'id_lancamento');
    }

    public function lancamento_taxa()
    {
        return $this->belongsTo('App\Models\LancamentoTaxa', 'id_lancamento');
    }

    public function lancamento_fundo()
    {
        return $this->belongsTo('App\Models\LancamentoFundo', 'id_lancamento');
    }

//    public static function createlancamentos(array $attributes = [])
//    {
//        $model = Lancamento::create($attributes);
//        array_add($attributes,'id_lancamento',$model->id);
//        return parent::create($attributes);
//    }

    public function tipo_lancamento()
    {
        return $this->hasOne('App\Models\TipoLancamento','id');
    }

    public function getValorFormat($value)
    {
        return DataHelper::getReal2Float($value);
    }
}
