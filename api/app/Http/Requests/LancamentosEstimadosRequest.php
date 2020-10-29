<?php

namespace App\Http\Requests;

use App\Models\LancamentosEstimados;
use Illuminate\Foundation\Http\FormRequest;

class LancamentosEstimadosRequest extends FormRequest
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
        $Data = LancamentosEstimados::find($this->lancamentos_estimados);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'id_tipolancamento' => 'required|exists:tipo_lancamentos,id',
                    'id_grupolancamento' => 'required|exists:grupo_lancamentos,id',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'id_tipolancamento' => 'required|exists:tipo_lancamentos,id',
                    'id_grupolancamento' => 'required|exists:grupo_lancamentos,id',
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
