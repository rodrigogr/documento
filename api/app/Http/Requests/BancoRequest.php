<?php

namespace App\Http\Requests;

use App\Models\Banco;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;
use Symfony\Component\DomCrawler\Form;


class BancoRequest extends FormRequest {
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
        $Data = Banco::find($this->banco);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'codigo' => 'required|min:3|max:20',
                    'descricao' => 'required|min:3|max:100',
                    'url' => 'required|min:3|max:500',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'codigo' => 'required|min:3|max:20',
                    'descricao' => 'required|min:3|max:100',
                    'url' => 'required|min:3|max:500',
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
