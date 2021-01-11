<?php

namespace App\Http\Requests\Reservas;

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
                    'nome' => 'required'
                ];
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'nome' => 'required'
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