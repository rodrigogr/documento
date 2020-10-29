<?php

namespace App\Http\Requests;

use App\Models\SituacaoImovel;
use Illuminate\Foundation\Http\FormRequest;

class SituacaoImovelRequest extends JsonRequest
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
        $Data = SituacaoImovel::find($this->situacao_imovel);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|unique:situacao_imoveis|min:10|max:100',
                    'percentual_desconto' => 'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|unique:situacao_imoveis,descricao,' . $id . ',id|min:10|max:100',
                    'percentual_desconto' => 'required'
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
