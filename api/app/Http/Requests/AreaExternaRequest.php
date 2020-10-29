<?php

namespace App\Http\Requests;

use App\Models\AreaExterna;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class AreaExternaRequest extends JsonRequest
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
                    'idimovel' => 'required|exists:imovel,id',
                    'idtipo_area_externa' => 'required|exists:tipo_area_externas,id',
                    'quantidade' => 'required|numeric',
                    'area_construida' => 'required|numeric'
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idimovel' => 'required|exists:imovel,id',
                    'idtipo_area_externa' => 'required|exists:tipo_area_externas,id',
                    'quantidade' => 'required|numeric',
                    'area_construida' => 'required|numeric'
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
