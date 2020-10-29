<?php

namespace App\Services;

use App\Helpers\DataHelper;
use App\Models\Estimado;
use App\Models\Imovel;
use App\Models\Informativo;
use App\Models\ParcelaBoleto;
use App\Models\Pessoa;
use App\Models\Condominio;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\ImageManagerStatic as Image;

class FaturaService
{
	public function htmlFatura($id_parcela,$mes, $ano){
		$estimado = Estimado::complete()->where('mes_competencia',$mes)->where('ano_competencia',$ano)->groupBy('id_grupolancamento');
		$parcela_boleto = ParcelaBoleto::find($id_parcela);
		$condominio = Condominio::all()->first()->get();
		$today = date("Y-m-d");
		$informativo = Informativo::where('datainicial','<=' ,$today)->where('datafinal','>=',$today)->get();
		return 
			"<table style='height: 100%'>
				<tbody>
					<tr>
						<td>
							<!-- HEADER -->
							".$this->header($parcela_boleto,$condominio,$mes, $ano)."
							<!-- SUB HEADER -->
							".$this->subHeader($parcela_boleto)."
							<!-- BODY -->
							".$this->body($estimado, $condominio,$parcela_boleto)."
							<!-- INFORMATIVO -->
							".$this->informativo($informativo)."
						</td>
					</tr>
				</tbody>
			</table>
			<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
			<style>
				table {
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

	private function header($parcela_boleto,$condominio,$mes, $ano){
        $exists = Storage::disk('condominio')->exists('logo.jpg');
        $path_logo = '';
	    if($exists) {
            $path_logo = storage_path('app/condominio/logo.jpg');
        }
		return "
			<table class='module' style='background-color: #C0C0C0;'>
				<tbody>
					<tr>
						<td style='width: 50%;'>
							<table>
								<tbody>
									<tr>
										<td style='width: 74px;'><img height='50' src='".$path_logo."' /></td>
										<td>
											<table>
												<tbody>
													<tr class='total'>
														<td><h3>Demostrativo de pagamento</h3></td>
													</tr>
													<tr>
														<td>".$condominio->first()->razao_social."</td>
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
														<td class='alignt-center bold'><h3>".$mes."/".$ano."</h3></td>
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
														<td class='circleBorder-bottom bold'><h3>".DataHelper::getPrettyDate($parcela_boleto->data_vencimento)."</h3></td>
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
			</table>";
	}

	private function subHeader($parcela_boleto){
		if($parcela_boleto->parcela->recebimento->empresa) {
			$nome = $parcela_boleto->parcela->recebimento->empresa->nome_fantasia;
			$endereco = $parcela_boleto->parcela->recebimento->empresa->endereco;
		}else{
			$nome = $parcela_boleto->parcela->recebimento->associado->nome;
			$endereco = $parcela_boleto->parcela->recebimento->imovel->logradouro . ' N '. ($parcela_boleto->parcela->recebimento->imovel->numero ? $parcela_boleto->parcela->recebimento->imovel->numero : 'SN');
		}
		$quadra = $parcela_boleto->parcela->recebimento->imovel->quadra;
		$lote = $parcela_boleto->parcela->recebimento->imovel->lote;
        $imovel_agregados = Imovel::join('imovel_agregado','imovel_agregado.id_imovel_principal', 'imovel.id')
            ->where('imovel_agregado.id_imovel_principal',$parcela_boleto->parcela->recebimento->imovel->id )
            ->where('imovel_agregado.softdeleted', 0)
            ->get();
        if (count($imovel_agregados)){
            foreach ($imovel_agregados as $imovel_agregado){
                $lote = $lote . '/' . $imovel_agregado->lote;
            }
        }
		return 
			"<table class='module'>
				<tbody>
					<tr>
						<td style='width: 50%;'>
							<table>
								<tbody>
									<tr>
										<td class='bold'>$nome</td>
									</tr>
									<tr>
										<td>
											<p>$endereco</p>
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
										<td class='circleBorder-bottom bold'><h3>$quadra</h3></td>
										<td class='circleBorder-bottom bold'><h3>$lote</h3></td>
										<td class='circleBorder-bottom bold'><h3>R$ ".DataHelper::getFloat2Real($parcela_boleto->parcela->valor)."</h3></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>";
	}

	private function body($estimado, $condominio, $parcela_boleto){
		$previsoes = '';
		$totalDespesas = 0;
		foreach ($estimado as $item){
			$name = $item[0]->grupo_lancamento->descricao;
			$valor = 0;
			foreach($item as $subItem){
				$valor = $valor + $subItem->valor;
			}
			$totalDespesas = $totalDespesas + $valor;
			$previsoes .= "<tr><td>$name</td><td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($valor)."</td></tr>";
		}
		$lancamentos = '';
		$totalLancamentos = 0;
		foreach ($parcela_boleto->parcela->recebimento->lancamentos as $lancamento) {
		    if($lancamento->lancamento->categoria == 7) {
                $totalLancamentos = $totalLancamentos - $lancamento->lancamento->valor;
                $lancamentos .= "<tr><td>" . $lancamento->lancamento->descricao ." </td><td class='alingCurrency'> - R$ ".DataHelper::getFloat2Real($lancamento->lancamento->valor)."</td></tr>";
            } else {
                $totalLancamentos = $totalLancamentos + $lancamento->lancamento->valor;
                $lancamentos .= "<tr><td>" . $lancamento->lancamento->descricao ." </td><td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($lancamento->lancamento->valor)."</td></tr>";
            }
		}
		$area_total = Imovel::getAreaTotalCondominio();
        $valor_rateio = 0;
		if($area_total > 0) {
            $valor_rateio = DataHelper::getxDecimalCurrency(($totalDespesas * 1.1)/$area_total,4);
        }

		$boletos_abertos = ParcelaBoleto::join('recebimento_parcelas','recebimento_parcelas.id','=','parcela_boletos.id_parcela')
				->join('recebimentos','recebimento_parcelas.id_recebimento','=','recebimentos.id')
				->select('data_vencimento','nosso_numero','valor')
				->where('situacao', 'Provisionado')
                ->where('data_vencimento', '<', \DB::raw('CURDATE()'))
				->where('idimovel', $parcela_boleto->parcela->recebimento->idimovel)
				->get();
		$totalaberto = 0;
		$titulos_abertos = '';
		$total_html = '';
		$i =1;
		if(count($boletos_abertos)>5){
				foreach ($boletos_abertos as $aberto) {
						$titulos_abertos .= "<tr><td>" . $aberto->data_vencimento . "</td><td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($aberto->valor)."</td></tr>";
						if ($i++ == 5) break;
				}
				$total_html = 
					"<tr class='total'>
							<td><small>*Existem mais boletos em abertos.</small>
						</td>
					</tr>";
		} else {
			foreach ($boletos_abertos as $aberto) {
					$totalaberto = $totalaberto + $aberto->valor;
					$titulos_abertos .= "<tr><td>" . $aberto->data_vencimento . " </td><td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($aberto->valor)."</td></tr>";
			}
			$total_html = "<tr class='total'>
													<td>TOTAL</td>
						<td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($totalaberto)."</td>
					</tr>";
		}
		return 
			"<table class='module'>
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
																	$previsoes
																	<tr class='total'>
																		<td>TOTAL DE DESPESAS </td>
																		<td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($totalDespesas)."</td>
																	</tr>
																	<tr class='total'>
																		<td>TOTAL C/ FUNDO DE RESERVA (10%)</td>
																		<td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($totalDespesas * 1.1)."</td>
																	</tr>
																	<tr class='total'>
																		<td>TOTAL DO RATEIO POR M²</td>
																		<td class='alingCurrency'>R$ ".$valor_rateio."</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
													<tr>
														<td style='text-align: center;'><small>*As previsões de despesas são utilizadas para gerar a taxa associativa.
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
																	$lancamentos
																	<tr class='total'>
																		<td>TOTAL</td>
																		<td class='alingCurrency'>R$ ".DataHelper::getFloat2Real($totalLancamentos)."</td>
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
																	$titulos_abertos
																	$total_html
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
			</table>";
	}

	private function informativo($informativo){
		$info = '';
		foreach ($informativo as $item){
			if($item->image){
				$image = Image::make($item->image);
				$height = 300;
				$width = round(($image->width() * $height) / $image->height());
				$item->image = $image->fit($width, $height)->encode('data-url');
				$item->image = "<img src='".$item->image."'/>";
			} else{
				$item->image = "";
			}
			$info .= "<table><tbody><tr style='width: fit-content;'><td>$item->image</td><td>$item->conteudo</td></tr></tbody></table>";
		}
		if($info == '') return '';
		else { return
			"<table class='module'>
				<tbody>
					<tr style='height: 23px;'><td class='title'>INFORMATIVO</td></tr>
					<tr ><td>$info</td></tr>
				</tbody>
			</table>";
		}
	}
}