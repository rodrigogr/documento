<?php

namespace App\Http\Requests;

use App\Helpers\DataHelper;
use App\Models\Associado;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class AssociadoRequest extends JsonRequest
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
        $Data = Associado::find($this->associado);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }
            case 'POST': {
                return [
                    'idramo_atividades' => 'required|exists:ramo_atividades,id',
                    'idtipo_correspondencia' => 'required|exists:tipo_correspondencias,id',
                    'nome' => 'required|min:3|max:255',
                    'cpf' => 'required|cpf|unique:associados',
                    'rg' => 'required|min:7|unique:associados',
                    'natureza' => 'required',
                    'nome_mae' => 'required|min:10|max:255',
                    'nome_pai' => 'required|min:10|max:255',
                    'data_nascimento' => 'required',
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idramo_atividades' => 'required|exists:ramo_atividades,id',
                    'idtipo_correspondencia' => 'required|exists:tipo_correspondencias,id',
                    'nome' => 'required|min:3|max:255',
                    'cpf' => 'required|cpf|unique:associados,cpf,' . $id . ',id',
                    'rg' => 'required|min:7|unique:associados,rg,' . $id . ',id',
                    'natureza' => 'required',
                    'nome_mae' => 'required|min:10|max:255',
                    'nome_pai' => 'required|min:10|max:255',
                    'data_nascimento' => 'required',
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
        if ($this->is('api/*')) {
            return response()->error($errors);
        } else {
            return \Redirect::back()->withErrors($errors)->withInput();
        }
    }

    protected function getValidatorInstance()
    {
        $input = array_map('trim', $this->all());
        $input['cpf'] = ($input['cpf'] != '') ? DataHelper::getOnlyNumbers($input['cpf']) : $input['cpf'];
        $input['rg'] = ($input['rg'] != '') ? DataHelper::getOnlyNumbers($input['rg']) : $input['rg'];
        $this->replace($input);
        return parent::getValidatorInstance();
    }
}
