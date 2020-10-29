<?php

namespace App\Http\Requests;

use App\Models\Produto;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class ProdutoRequest extends JsonRequest
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
        $Data = Produto::find($this->produto);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'idunidade_produto' => 'required|exists:unidade_produtos,id',
                    'idgrupo_produto' => 'required|exists:grupo_produtos,id',
                    'referencia' => 'required|unique:produtos',
                    'descricao' => 'required|unique:produtos|min:3|max:100',
                    'origem' => 'required',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'idunidade_produto' => 'required|exists:unidade_produtos,id',
                    'idgrupo_produto' => 'required|exists:grupo_produtos,id',
                    'referencia' => 'required|unique:produtos,descricao,' . $id . ',id',
                    'descricao' => 'required|unique:produtos,descricao,' . $id . ',id|min:3|max:100',
                    'origem' => 'required',
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
