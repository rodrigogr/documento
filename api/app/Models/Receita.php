<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receita extends Model
{

    protected $connection = 'portaria';
    public $timestamps = true;
    protected $fillable = [
        'percentualmulta',
        'percentualjuros',
        'modalidadejuro',
        'periodicidadedojuro',
        'incidircorrecao',
        'indicecorrecao',
        'visualizarinstrucao',
        'instrucaosacado',
        'localdepagamento',
        'anexarprestacaodecontas',
        'mesprestacaodeconta',
        'versoboleto',
        'tempoinadimplencia',
        'valortolerancia',
        'id_configuracao_carteira',
        'id_tipolancamentomulta',
        'id_tipolancamentojuros',
        'id_tipolancamentocorrecao',
        'id_tipolancamentocustasadicionais',
        'id_tipolancamentodesconto',
        'id_tipoinadimplenciapadrao',
        'id_tipolancamentoabatimento',
        'id_tipolancamentojuridico'
    ];
    static public $associations = [
        'carteiraBancaria',
        'tipoLancamentoMulta',
        'tipoLancamentoJuros',
        'tipoLancamentoCorrecao',
        'tipoLancamentoCustasAdicionais',
        'tipoLancamentoDesconto',
        'tipoInadimplenciaPadrao'
    ];
    static public function complete($id = NULL)
    {
        return ($id != NULL) ? self::where('id', $id)->with(self::$associations)->first() : self::with(self::$associations)->get();
    }

    // ******************** RELASHIONSHIP ******************************
    // ************************** hasOne ****************************

    public function carteiraBancaria()
    {
        return$this->belongsTo('App\Models\ConfiguracaoCarteira','id_configuracao_carteira');
    }
    public function tipoLancamentoMulta()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentomulta');
    }

    public function tipoLancamentoJuros()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentojuros');
    }

    public function tipoLancamentoCorrecao()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentocorrecao');
    }

    public function tipoLancamentoCustasAdicionais()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentocustasadicionais');
    }

    public function tipoLancamentoDesconto()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentodesconto');
    }

    public function tipoInadimplenciaPadrao()
    {
        return $this->belongsTo('App\Models\TipoInadimplencia', 'id_tipoinadimplenciapadrao');
    }

    public function tipoLancamentoAbatimento()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentoabatimento');
    }

    public function tipoLancamentoJuridico()
    {
        return $this->belongsTo('App\Models\TipoLancamento', 'id_tipolancamentojuridico');
    }
}
