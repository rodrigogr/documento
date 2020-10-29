<?php

namespace App\Http\Requests;

use App\Models\GrupoCalculo;
use Illuminate\Foundation\Http\FormRequest;

class GrupoCalculoRequest extends FormRequest
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
       $Data = GrupoCalculo::find($this->grupocalculo);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|unique:grupo_calculo|min:3|max:100',
                    'percentualfundoreserva' => 'required',
                    'id_tipolancamento_taxaassociativa' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamento_fundoreserva' => 'exists:tipo_lancamentos,id',
                    'id_formula' => 'required',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|unique:grupo_calculo,descricao,' . $id . ',id|min:3|max:100',
                    'percentualfundoreserva' => 'required',
                    'id_tipolancamento_taxaassociativa' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamento_fundoreserva' => 'exists:tipo_lancamentos,id',
                    'formula' => 'required',
                ];
                break;
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
