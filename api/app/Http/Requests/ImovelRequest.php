<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class ImovelRequest extends JsonRequest
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
                    'idproprietario' => 'required|exists:associados,id',
//                    'idinquilino'       => 'somethimes|exists:associados,id',
                    'idlocalidade' => 'required|exists:localidades,id',
                    'idsituacao_imovel' => 'required|exists:situacao_imoveis,id',
                    'cep' => 'required',
                    'quadra' => 'required',
                    'lote' => 'required',
                    'logradouro' => 'required',
                    'obs' => 'required',
                    'status' => 'required',
                    'area_imovel' => 'required|numeric',
                    'area_construida' => 'required|numeric',
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idproprietario' => 'required|exists:associados,id',
//                    'idinquilino'       => 'required|exists:associados,id',
                    'idlocalidade' => 'required|exists:localidades,id',
                    'idsituacao_imovel' => 'required|exists:situacao_imoveis,id',
                    'cep' => 'required',
                    'quadra' => 'required',
                    'lote' => 'required',
                    'logradouro' => 'required',
                    'obs' => 'required',
                    'status' => 'required',
                    'area_imovel' => 'required|numeric',
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
