<?php

namespace App\Http\Controllers;

use App\Http\Requests\InformativoRequest;
use App\Models\Informativo;
use Illuminate\Http\Request;
use League\Flysystem\Exception;
use finfo;
use App\PrintPdf;
use Intervention\Image\ImageManagerStatic as Image;

class InformativoController extends Controller
{
    private $name = 'Informativo';
    public function index(){
        $Data = Informativo::paginate(14);
        foreach($Data->items() as $data){
            $data->image = null;
        }
       return response($Data);
    }

    public function store(InformativoRequest $request){
        try {
            $data = $request->all();
            $Data = Informativo::create($data);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
        return response()->success(trans('messages.crud.MSS', ['name' => $this->name]));
    }

    public function show($id){
        $Data = Informativo::find($id);
        $Data->image = '';
        if (count($Data)) {
            return response()->success($Data);
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function update(Request $request, $id){
        $Data = Informativo::find($id);
        if (count($Data)) {
            try {
                $data = $request->all();
                $Data->update($data);
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.MUS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function destroy($id){
        $Data = Informativo::find($id);
        if (count($Data)) {
            try {
                $Data->delete();
            } catch (Exception $e) {
                return response()->error($e->getMessage());
            }
            return response()->success(trans('messages.crud.MDS', ['name' => $this->name]));
        } else {
            return response()->error(trans('messages.crud.MGE', ['name' => $this->name]));
        }
    }

    public function getImage64(Request $request, $id){
        try {
            $Data = Informativo::find($id);
            return response()->make($Data->image, 200, array(
                'Content-Type' => (new finfo(FILEINFO_MIME))->buffer($Data->image)
            ));
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    public function getVisualizar(Request $request, $id){
        try {
            $Data = Informativo::find($id);
            if($Data->image){
                $image = Image::make($Data->image);
				$height = 300;
				$width = round(($image->width() * $height) / $image->height());
                $Data->image = $image->fit($width, $height)->encode('data-url');
                $Data->image = "<img src='".$Data->image."'/>";
            } else {
                $Data->image = '';
            }
            $html = $this->fatura($Data);
            // return response($html);
            $mpdf = new PrintPdf('','','','',5,5,5,5);
            $mpdf->SetTitle('Visualizar Informativo');
            $mpdf->WriteHTML($html);
            $output = $mpdf->Output();
            return response($output, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'inline; Boleto',
            ]);
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }

    function fatura($Data){
        $exists = \Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
        if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
        return "
        <table style='height: 100%'>
            <tbody>
                <tr>
                    <td>
                        <!-- HEADER -->
                        <table class='module' style='background-color: #C0C0C0;'>
                            <tbody>
                                <tr>
                                    <td style='width: 50%;'>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td style='width: 74px;'>
                                                        <img height='50' src='".$path_logo."' />
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr class='total'>
                                                                    <td>
                                                                        <h3>Demostrativo de pagamento</h3>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>ASSOCIAÇÃO JARDINS VALENCIA</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style='width: 50%;'>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td class='alignt-center'>competência</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class='alignt-center bold'>
                                                                        <h3>8/2017</h3>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td class='circleBorder-top'>vencimento</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class='circleBorder-bottom bold'>
                                                                        <h3>26/09/2017</h3>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- SUB HEADER -->
                        <table class='module'>
                            <tbody>
                                <tr>
                                    <td style='width: 50%;'>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class='bold'>Fulado Cardoso da Silva</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <p>RUA DAS OLIVEIRAS N SN</p>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style='width: 50%;'>
                                        <table style='border-spacing: 10px 0px'>
                                            <tbody>
                                                <tr>
                                                    <td class='circleBorder-top'>quadra</td>
                                                    <td class='circleBorder-top'>lote</td>
                                                    <td class='circleBorder-top'>valor</td>
                                                </tr>
                                                <tr>
                                                    <td class='circleBorder-bottom bold'>
                                                        <h3>99</h3>
                                                    </td>
                                                    <td class='circleBorder-bottom bold'>
                                                        <h3>99</h3>
                                                    </td>
                                                    <td class='circleBorder-bottom bold'>
                                                        <h3>R$ 547,64</h3>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- BODY -->
                        <table class='module'>
                            <tbody>
                                <tr>
                                    <td style='width: 50%;'>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td class='title'>PREVISÃO DE DESPESAS do condomínio*</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>DESPESAS BANCARIAS</td>
                                                                                    <td class='alingCurrency'>R$ 3.000,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>OBRIGAÇÕES TRABALHISTAS</td>
                                                                                    <td class='alingCurrency'>R$ 120.373,57</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ CONSUMOS</td>
                                                                                    <td class='alingCurrency'>R$ 9.760,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ SEGUROS/IMPOSTOS E TAXAS</td>
                                                                                    <td class='alingCurrency'>R$ 1.917,45</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ MANUTENÇÃO E REPAROS</td>
                                                                                    <td class='alingCurrency'>R$ 7.544,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ ADM., CONSERVAÇÃO, LIMPEZA E OUTROS</td>
                                                                                    <td class='alingCurrency'>R$ 4.700,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>IMOBILIZADOS</td>
                                                                                    <td class='alingCurrency'>R$ 17.300,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ PRESTAÇÃO DE SERVIÇOS / CONTRATOS</td>
                                                                                    <td class='alingCurrency'>R$ 146.407,96</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>DESPESAS C/ LOCAÇÃO E MANUTENÇÃO DOS MESMOS</td>
                                                                                    <td class='alingCurrency'>R$ 2.250,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>PROVISÕES</td>
                                                                                    <td class='alingCurrency'>R$ 20.742,00</td>
                                                                                </tr>
                                                                                <tr class='total'>
                                                                                    <td>TOTAL DE DESPESAS </td>
                                                                                    <td class='alingCurrency'>R$ 333.994,98</td>
                                                                                </tr>
                                                                                <tr class='total'>
                                                                                    <td>TOTAL C/ FUNDO DE RESERVA (10%)</td>
                                                                                    <td class='alingCurrency'>R$ 367.394,48</td>
                                                                                </tr>
                                                                                <tr class='total'>
                                                                                    <td>TOTAL DO RATEIO POR M²</td>
                                                                                    <td class='alingCurrency'>R$ 1,3892</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style='text-align: center;'>
                                                                        <small>*As previsões de despesas são utilizadas para gerar a taxa associativa.
                                                                    O detalhamento destas despesas estão anexadas à parte.</small>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style='width: 50%;'>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td class='title'>LANÇAMENTO DESTA FATURA</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>Taxa associativa</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Multa</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Taxa da academa do mês de agosto e tal pra ficar em 2 linhas</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Outra coisa</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Taxa associativa</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr class='total'>
                                                                                    <td>TOTAL</td>
                                                                                    <td class='alingCurrency'>R$ 231.873,00</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <td class='title'>TÍTULOS EM ABERTO</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>TAXA DA DEDETIZACÃO</td>
                                                                                    <td class='alingCurrency'>R$ 200,00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>CONDOMÍNIO AGO/2017</td>
                                                                                    <td class='alingCurrency'>R$ 100,00</td>
                                                                                </tr>
                                                                                <tr class='total'>
                                                                                    <td>TOTAL</td>
                                                                                    <td class='alingCurrency'>R$ 231.873,00</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- INFORMATIVO -->
                        <table class='module'>
                            <tbody>
                                <tr style='height: 23px;'>
                                    <td class='title'>INFORMATIVO</td>
                                </tr>
                                <tr >
                                    <td>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td style='width: fit-content;'>
                                                        $Data->image
                                                    </td>
                                                    <td>$Data->conteudo</tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
        <style>
                    table {
                            font-family: arial, sans-serif;
                            width: 100%;
                            border-collapse: separate;
                            border-spacing: 0;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    td,th {
                            padding: 5px;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    .circleBorder-top {
                            border-top: 1px solid black;
                            border-right: 1px solid black;
                            border-left: 1px solid black;
                            border-collapse: separate;
                            text-align: center;
                            text-transform: uppercase;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    .circleBorder-bottom {
                            border-bottom: 1px solid black;
                            border-right: 1px solid black;
                            border-left: 1px solid black;
                            border-collapse: separate;
                            text-align: center;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    .module {
                            width: 100%;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                            margin-top: 10px;
                    }
                    .title {
                            text-align: center;
                            text-transform: uppercase;
                            font-weight: bold;
                            background-color: #C0C0C0;
                            border-bottom: 1px solid black;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    .total td {
                            font-weight: bold;
                            text-transform: uppercase;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    .alingCurrency {
                            text-align: right;
                            font-family: 'Roboto', sans-serif;
                            font-size: x-small;
                    }
                    table td,table td * {
                            vertical-align: top;
                            font-family: 'Roboto', sans-serif;
                        font-size: x-small;
                    }
                    .alignt-center{
                        text-align: center;
                        text-transform: uppercase;
                    }
                    .bold{
                        font-size: small;
                        font-weight: bold;
                    }
                </style>";
    }

    public function getImage(Request $request, $id){
        try {
            $Data = Informativo::find($id);
            if($Data->image) $image = base64_decode(str_replace('data:image/png;base64,', '', $Data->image));
            return response()->make($image, 200, array(
                'Content-Type' => (new finfo(FILEINFO_MIME))->buffer($image)
            ));
        } catch (Exception $e) {
            return response()->error($e->getMessage());
        }
    }
}