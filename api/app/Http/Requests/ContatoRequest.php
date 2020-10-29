<?php

namespace App\Http\Requests;

use App\Models\Contato;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class ContatoRequest extends JsonRequest
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
        $data = Contato::find($this->contato);
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }

            case 'POST': {
                return [
                    'idtipo_correspondencia' => 'required|exists:tipo_correspondencias,id',
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idtipo_correspondencia' => 'required|exists:tipo_correspondencias,id',
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
