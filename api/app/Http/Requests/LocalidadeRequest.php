<?php

namespace App\Http\Requests;

use App\Models\Localidade;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class LocalidadeRequest extends JsonRequest
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
        $Data = Localidade::find($this->localidade);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|unique:localidades|min:10|max:100',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|unique:localidades,descricao,' . $id . ',id|min:10|max:100',
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
