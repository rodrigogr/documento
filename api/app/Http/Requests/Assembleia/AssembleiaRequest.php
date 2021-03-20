<?php

namespace App\Http\Requests\Assembleia;

use App\Http\Requests\JsonRequest;
use App\models\Assembleia\Assembleia;

class AssembleiaRequest extends JsonRequest
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
        $rules = [];

        switch ($this->method())
        {
            case 'GET':
            case 'DELETE':
            case 'POST': {
                $rules = [
                    'titulo' => 'required',
                    'tipo' => 'required',
                    'data_inicio' => 'required',
                    'hora_inicio' => 'required'
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                $rules = [
                    'titulo' => 'required',
                    'tipo' => 'required',
                    'data_inicio' => 'required',
                    'hora_inicio' => 'required'
                ];
                break;
            }
        }

        return $rules;
    }

    /**
     * Get the response that handle the request errors.
     *
     * @param  array $errors
     * @return array
     */
    public function response(array $errors)
    {
        if ($this->is('api/*'))
        {
            return response()->error($errors);
        } else
        {
            return \Redirect::back()->withErrors($errors)->withInput();
        }
    }
}
