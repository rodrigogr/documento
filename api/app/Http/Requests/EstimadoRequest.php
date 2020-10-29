<?php

namespace App\Http\Requests;

use App\Models\Estimado;
use App\Models\Lancamento;
use Illuminate\Foundation\Http\FormRequest;

class EstimadoRequest extends FormRequest
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
        $Data = Estimado::find($this->estimado);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'mes_competencia' => 'numeric|required',
                    'ano_competencia' => 'numeric|required',
                    'lancamentos'=> 'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [

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
