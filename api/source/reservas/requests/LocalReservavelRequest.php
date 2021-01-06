<?php
namespace Source\Reservas\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LocalReservavelRequest extends FormRequest
{
    public function authorize(){
        return true;
    }

    public function rules()
    {
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
            }
            case 'POST': {
                return [
                    'tipo' => 'required',
                    'conteudo' => 'required',
                    'datainicial' => 'required',
                    'datafinal' => 'required'
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'tipo' => 'required',
                    'conteudo' => 'required',
                    'datainicial' => 'required',
                    'datafinal' => 'required'
                ];
            }
            default:
                return [];
        }
    }

    public function response(array $errors){
        if ($this->is('api/*')) {
            return response()->error($errors);
        } else {
            return \Redirect::back()->withErrors($errors)->withInput();
        }
    }

}