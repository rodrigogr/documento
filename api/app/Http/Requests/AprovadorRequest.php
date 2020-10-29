<?php

namespace App\Http\Requests;

use App\Models\Aprovador;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class AprovadorRequest extends JsonRequest
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
        $Data = Aprovador::find($this->Aprovador);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'idusuario' => 'required|exists:usuario,id',
                    'email' => 'required',
                    'tipo' => 'required',
                    
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idusuario' => 'required|exists:usuario,id',
                    'email' => 'required',
                    'tipo' => 'required',
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
