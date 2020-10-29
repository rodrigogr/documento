<?php

namespace App\Http\Requests;

use App\Models\Telefone;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;

class TelefoneRequest extends JsonRequest
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
                    'idcontato' => 'required|exists:contatos,id',
                    'idtipo_telefone' => 'required|exists:tipo_telefones,id',
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idcontato' => 'required|exists:contatos,id',
                    'idtipo_telefone' => 'required|exists:tipo_telefones,id',
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
        $content = [
            'status' => 0,
            'response' => $errors
        ];
        return new JsonResponse($content, 422);
    }
}
