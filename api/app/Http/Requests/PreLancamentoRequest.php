<?php

namespace App\Http\Requests;

use App\Models\PreLancamento;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class PreLancamentoRequest extends FormRequest
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
        $Data = PreLancamento::find($this->pre_lancamento);
        $id = count($Data) ? $Data->id_lancamento : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|min:3|max:100',
                    'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'idimovel' => 'required|exists:imovel,id',
                    'valor' => 'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|min:3|max:100',
                    'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'idimovel' => 'required|exists:imovel,id',
                    'valor' => 'required'
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
