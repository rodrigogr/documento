<?php

namespace App\Http\Requests;

use App\Models\CondominioConfiguracoes;
use Illuminate\Foundation\Http\FormRequest;

class CondominioConfiguracoesRequest extends FormRequest
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
        $Data = CondominioConfiguracoes::find($this->condominioconfiguracoes);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'diavencimento' => 'required',
                    'diaapuracao' => 'required',
                    'periododaapuracao' => 'required',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'diavencimento' => 'required',
                    'diaapuracao' => 'required',
                    'periododaapuracao' => 'required',
                ];
                break;
            }
            default:
                break;
        }
    }
}
