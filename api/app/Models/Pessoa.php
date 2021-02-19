<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 13/01/17
 * Time: 10:43
 */
namespace App\Models;

use App\Helpers\DataHelper;
use Eduardokum\LaravelBoleto\Util;
use Illuminate\Database\Eloquent\Model;



class Pessoa extends Model {
    protected $connection = 'portaria';
    public $timestamps = false;
    protected $table = 'pessoa';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'nome',
        'cpf',
        'data_cadastro',
        'data_nascimento',
        'sexo',
        'mae',
        'apresenta_mensagem_entrada',
        'mensagem',
        'obs_seguranca',
        'id_cnh',
        'id_usuario_atendente',
        'tipo',
        'url_foto',
        'rg',
        'ultima_alteracao',
        'tel1',
        'tel2',
        'pessoa_permanente',
        'outro_documento',
        'tipo_outro_documento',
        'orgao_expeditor',
        'cel3',
        'cel4',
        'agrupar_titulos'
    ];

    public function setCpfAttribute($value)
    {
        return $this->attributes['cpf'] = DataHelper::getOnlyNumbers($value);
    }

    public function setRgAttribute($value)
    {
        return $this->attributes['rg'] = DataHelper::getOnlyNumbers($value);
    }

    public function getRgAttribute($value)
    {
        return DataHelper::mask($value, '#.###.###-##');
    }

    public function setDataNascimentoAttribute($value)
    {
        return $this->attributes['data_nascimento'] = DataHelper::setDate($value);
    }

    public function getDataNascimentoAttribute($value)
    {
        return DataHelper::getPrettyDate($value);
    }
    // ******************** RELASHIONSHIP ******************************
    // ************************** belongsTo ****************************
    public function cnh(){
        return $this->belongsTo('App\Models\Cnh', 'id_cnh');
    }

    public function usuario() {
        return $this->belongsTo('App\Models\Usuario', 'id_usuario_atendente');
    }
    // ************************** hasOne *******************************

    // ************************** hasMany ******************************
    public function inquilinos_imoveis()
    {
        return $this->hasMany('App\Models\ImovelPermanente', 'id_pessoa');
    }

    public function  morador()
    {
        return $this->hasOne('App\Models\PessoaPermanente', 'id_pessoa');
    }


}