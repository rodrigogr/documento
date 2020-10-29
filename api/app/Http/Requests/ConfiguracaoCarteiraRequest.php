<?php

namespace App\Http\Requests;

use App\Models\ConfiguracaoCarteira;
use Illuminate\Foundation\Http\FormRequest;

class ConfiguracaoCarteiraRequest extends FormRequest
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
        $Data = ConfiguracaoCarteira::find($this->configuracao_carteira);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }
            case 'POST': {
                return [
                    'id_conta_bancaria' => 'required|exists:conta_bancarias,id',
                    'id_carteira' => 'required|exists:carteiras,id',
                    'id_layout_remessa' => 'required|exists:layout_remessas,id',
                    'id_layout_retorno' => 'required|exists:layout_retornos,id'
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'id_conta_bancaria' => 'required|exists:conta_bancarias,id',
                    'id_carteira' => 'required|exists:carteiras,id',
                    'id_layout_remessa' => 'required|exists:layout_remessas,id',
                    'id_layout_retorno' => 'required|exists:layout_retornos,id'
                ];
            }
            default:
                break;
        }
    }

    /**
     * Get the response that handle the request errors.
     *
     * @param  array $errors
     * @return array
     */
    public function response(array $errors)
    {
        if ($this->is('api/*')) {
            return response()->error($errors);
        } else {
            return \Redirect::back()->withErrors($errors)->withInput();
        }
    }
}
