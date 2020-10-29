<?php

namespace App\Http\Requests;

use App\Models\TipoLancamento;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class TipoLancamentoRequest extends FormRequest
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
        $Data = TipoLancamento::find($this->tipo_lancamento);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'idgrupo_lancamento' => 'required|exists:grupo_lancamentos,id',
                    'descricao' => 'required|min:3|max:100',
                    'fluxo' => 'required',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idgrupo_lancamento' => 'required|exists:grupo_lancamentos,id',
                    'descricao' => 'required|unique:tipo_lancamentos,descricao,' . $id . ',id|min:3|max:100',
                    'fluxo' => 'required',
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
