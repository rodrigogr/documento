<?php

namespace App\Http\Requests;

use App\Models\LancamentoAvulso;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;


class LancamentoAvulsoRequest extends FormRequest
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
        $Data = LancamentoAvulso::find($this->lancamento_avulso);
        $id = count($Data) ? $Data->id_lancamento : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'id_configuracao_carteira' => 'required|exists:configuracao_carteiras,id',
                    'id_empresa' => 'exists:empresa,id',
                    'id_layout_remessa' => 'required|exists:layout_remessas,id',
                    //'idimovel' => 'exists:imovel,id',
                    //'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    //'descricao' => 'required|min:3|max:100',
                    //'valor' => 'required',
                    'data_vencimento' => 'required',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'id_configuracao_carteira' => 'required|exists:configuracao_carteiras,id',
                    'id_layout_remessa' => 'required|exists:layout_remessas,id',
                    'idimovel' => 'required|exists:imovel,id',
                    'idtipo_lancamento' => 'required|exists:tipo_lancamentos,id',
                    'descricao' => 'required|min:3|max:100',
                    'valor' => 'required',
                    'data_vencimento' => 'required',
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
