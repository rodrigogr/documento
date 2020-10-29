<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\TipoDocumento;

class TipoDocumentoRequest extends FormRequest
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
        $Data = TipoDocumento::find($this->tipo_documento);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'nome' => 'required|unique:tipo_documentos|min:3|max:100',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'nome' => 'required|unique:tipo_documentos,nome,' . $id . ',id|min:3|max:100',
                ];
                break;
            }
            default:
                break;
        }
    }
}
