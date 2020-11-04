<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 12/01/17
 * Time: 12:00
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Condominio extends Model {

    protected  $connection = 'portaria';
    protected $table = 'condominio';

    protected $fillable = [
        'data_cadastro',
        'razao_social',
        'nome_fantasia',
        'cnpj',
        'ie',
        'email',
        'data_atualizacao',
        'tel1',
        'endereco',
        'complemento',
        'numero',
        'cidade',
        'bairro',
        'estado',
        'cep',
        'area_total'
    ];
}