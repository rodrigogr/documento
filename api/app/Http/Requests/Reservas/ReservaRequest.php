<?php

namespace App\Http\Requests\Reservas;

use Illuminate\Foundation\Http\FormRequest;

class ReservaRequest extends FormRequest
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
                    'id_local_reservavel' => 'required',
                    'id_periodo' => 'required',
                    'id_imovel' => 'required',
                    'id_pessoa' => 'required'
                ];
            }
            case 'PATCH': {
                return [];
            }
            case 'PUT': {
                return [
                    'id_local_reservavel' => 'required',
                    'id_periodo' => 'required',
                    'id_imovel' => 'required',
                    'id_pessoa' => 'required'
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