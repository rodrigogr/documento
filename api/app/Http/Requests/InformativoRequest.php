<?php

namespace App\Http\Requests;

use App\Models\Informativo;
use Illuminate\Foundation\Http\FormRequest;

class InformativoRequest extends FormRequest
{

    public function authorize(){
        return true;
    }

    public function rules(){
        $Data = Informativo::find($this->informativo);
        $id = count($Data) ? $Data->id : 0;
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
                break;
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