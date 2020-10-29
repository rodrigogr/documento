<?php

namespace App\Http\Requests;

use App\Models\GrupoProduto;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class GrupoProdutoRequest extends JsonRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $Data = GrupoProduto::find($this->grupo_produto);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'descricao' => 'required|unique:grupo_produtos|min:1|max:100',
                    'depreciacao' =>'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'descricao' => 'required|unique:grupo_produtos,descricao,' . $id . ',id|min:1|max:100',
                    'depreciacao' =>'required'
                ];
                break;
            }
            default:
                break;
        }
    }

    public function response(array $errors)
    {
        if ($this->is('api/*')) {
            return response()->error($errors);
        } else {
            return \Redirect::back()->withErrors($errors)->withInput();
        }
    }
}
