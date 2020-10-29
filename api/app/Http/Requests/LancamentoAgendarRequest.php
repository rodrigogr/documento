<?php

namespace App\Http\Requests;

use App\Models\LancamentoAgendar;
use Illuminate\Foundation\Http\FormRequest;

class LancamentoAgendarRequest extends FormRequest
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
        $Data = LancamentoAgendar::find($this->lancamento_agendar);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|min:3|max:100',
                    'id_fornecedor' => 'required|exists:empresa,id',
                    'mes_competencia' => 'numeric|required',
                    'ano_competencia' => 'numeric|required',
                    'data_base' => 'required',
                    'valor' => 'numeric|required',
                    'id_localizacao' => 'required|exists:localidades,id',
                    'id_tipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'parcelas' => 'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|min:3|max:100',
                    'id_fornecedor' => 'required|exists:empresa,id',
                    'mes_competencia' => 'numeric|required',
                    'ano_competencia' => 'numeric|required',
                    'data_base' => 'required',
                    'valor' => 'numeric|required',
                    'id_localizacao' => 'required|exists:localidades,id',
                    'id_tipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'parcelas' => 'required'
                ];
                break;
            }
            default:
                break;
        }
    }

    public function attributes()
    {
        return[
            'descricao' => 'Descrição'
        ];

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
