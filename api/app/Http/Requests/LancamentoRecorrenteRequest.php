<?php

namespace App\Http\Requests;

use App\Models\LancamentoRecorrente;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class   LancamentoRecorrenteRequest extends FormRequest
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
        $Data = LancamentoRecorrente::find($this->lancamento_recorrente);
        $id = count($Data) ? $Data->id_lancamento : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                $validations = [
                    'descricao' => 'required',
                    'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'valor' => 'required|numeric',
                    'tipo_associacao' => 'required'
                ];
                $validations = ($this->get('tipo_associacao') == 'LOCALIZACAO') ? array_merge($validations, ['idlocalidade' => 'required|exists:localidades,id']) : $validations;
                return $validations;
//                return [
//                    'idlocalidade',
//                    'idtipo_lancamento',
//                    'valor',
//                    'tipo_associacao',
//                    'fixo'
//                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                $validations = [
                    'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'valor' => 'required',
                    'tipo_associacao' => 'required'
                ];
                $validations = ($this->get('tipo_associacao') == 'LOCALIZACAO') ? array_merge($validations, ['idlocalidade' => 'required|exists:localidades,id']) : $validations;
                return $validations;
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
