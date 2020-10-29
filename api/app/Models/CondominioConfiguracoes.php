<?php
/**
 * Created by PhpStorm.
 * User: rafaelgg
 * Date: 12/01/17
 * Time: 11:59
 */

namespace  App\Models;

use Illuminate\Database\Eloquent\Model;

class CondominioConfiguracoes extends  Model
{
    public $timestamps = true;

    protected  $fillable = [
        'calculomessubsequente',
        'compensarabatimento',
        'diavencimento',
        'diaapuracao',
        'periododaapuracao',
        'tipodeapuracao',
        'escopoapuracao'
    ];


    static public function gerarDataDevencimento()
    {
        $result = CondominioConfiguracoes::all('diavencimento', 'calculomessubsequente')->first();
        $data_vencimento= null;
        $messubsequente = $result->calculomessubsequente;
        $diavencimento = $result->diavencimento;

        if($messubsequente) {
            $calculo = ReceitaCalculo::all()->last();
            //Verifica se existe calculos, para pegar a data do ultimo calcuo
            if(count($calculo)){
                //Pega a data do ultimo calculo e acrecenta o proximo mes.
                $data_vencimento = date("d/m/Y", strtotime('+1 month',strtotime($calculo->getDataVencimento())));
            } else {
                //Pega a data atual e acrecenta um mes
                $data_vencimento = date("d/m/Y", strtotime('+1 month'));
            }

            //Tranforma em array
            $dataExplode = explode( "/",$data_vencimento );
            //Pega o mes e o ano
            $mes = $dataExplode[1];
            $ano = $dataExplode[2];
            //cria a data com o dia do vencimento configurado
            $data_vencimento = date( "d/m/Y",mktime(0,0,0,$mes,$diavencimento,$ano));

        }else{
            if (date('d') < $diavencimento){
                $dif = $diavencimento - date('d');
                $data_vencimento = date("d/m/Y", strtotime("+$dif day"));
            } else {
                $dif = date('d') - $diavencimento;
                $data_vencimento = date("d/m/Y", strtotime("-$dif day +1 month"));
            }
        }
        return $data_vencimento;
    }
}