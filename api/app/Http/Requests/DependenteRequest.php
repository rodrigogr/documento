<?php

namespace App\Http\Requests;

use App\Helpers\DataHelper;
use App\Models\Dependente;



class DependenteRequest extends JsonRequest
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
        $Data = Dependente::find($this->dependente);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }
            case 'POST': {
                return [
                    'idassociado' => 'required|exists:associados,id',
                    'nome' => 'required|min:3|max:255',
                    'cpf' => 'required|unique:dependentes|min:7',
                    'rg' => 'required|unique:dependentes|min:7',
                    'genero' => 'required',
                    'telefone' => 'required',
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idassociado' => 'required|exists:associados,id',
                    'nome' => 'required|min:3|max:255',
                    'cpf' => 'required|unique:dependentes,cpf,' . $id . ',id|min:7',
                    'rg' => 'required|unique:dependentes,rg,' . $id . ',id|min:7',
                    'genero' => 'required',
                    'telefone' => 'required',
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
