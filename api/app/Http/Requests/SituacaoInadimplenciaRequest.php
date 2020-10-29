<?php

namespace App\Http\Requests;

use App\Models\SituacaoInadimplencia;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class SituacaoInadimplenciaRequest extends JsonRequest
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
        $Data = SituacaoInadimplencia::find($this->situacao_inadimplencia);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'idtipo_inadimplencia' => 'required|exists:tipo_inadimplencias,id',
                    'descricao' => 'required|unique:situacao_inadimplencias|min:3|max:100',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idtipo_inadimplencia' => 'required|exists:tipo_inadimplencias,id',
                    'descricao' => 'required|unique:situacao_inadimplencias,descricao,' . $id . ',id|min:3|max:100',
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
