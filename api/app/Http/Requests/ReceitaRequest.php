<?php

namespace App\Http\Requests;

use App\Models\Receita;

class ReceitaRequest extends JsonRequest
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
        $Data = Receita::find($this->receita);
        $id = count($Data) ? $Data->id : 0;
        switch ($this->method()) {
            case 'GET':
            case 'DELETE': {
                return [];
                break;
            }
            case 'POST': {
                return [
                    'id_configuracao_carteira' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentomulta' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentojuros' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentocorrecao' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentocustasadicionais' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentodesconto' => 'exists:tipo_lancamentos,id',
                    'id_tipoinadimplenciapadrao' => 'exists:tipo_lancamentos,id',
                ];
                break;
            }
            case 'PUT':
            case 'PATCH': {
                return [
                    'id_configuracao_carteira' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentomulta' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentojuros' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentocorrecao' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentocustasadicionais' => 'exists:tipo_lancamentos,id',
                    'id_tipolancamentodesconto' => 'exists:tipo_lancamentos,id',
                    'id_tipoinadimplenciapadrao' => 'exists:tipo_lancamentos,id',
                ];
                break;
            }
            default:
                break;
        }
    }
}
