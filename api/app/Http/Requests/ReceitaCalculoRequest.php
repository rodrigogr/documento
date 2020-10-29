<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ReceitaCalculoRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }
            case 'POST': {
                return [
                    'despesa_total' => 'required',
                    'area_total'       => 'required',
                    'total_imoveis' => 'required',
                    'fracao_ideal' => 'required',
                    'tipo_apuracao' => 'required',
                    'data_vencimento' => 'required',
                    'percentual_juros' => 'required',
                    'percentual_multa' => 'required',
                    'percentual_fundo_reserva' => 'required',
                    'carteira' => 'required',

                ];
            }
            case 'PUT':
            case 'PATCH':
            default:
                break;
        }
    }
}
