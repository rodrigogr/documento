'use strict'
angular.module('ContasReceberModule').controller('SimulacaoCalculoReceitaCtrl',
	function ($scope, $filter, UtilsService, ReceitaService, LancamentoService, $http, config, HeaderFactory, AuthService, $state, $timeout) {
        HeaderFactory.setHeader('Receitas', 'Simulação e Cálculo');
		$scope.$ = $;

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
		$scope.ngOnInit = async () => {
			try {
				$('.loader').show();
				await Promise.all([
					// ReceitaService.getAllCalculoReceita().then(function (result) {
					// 	$scope.data.calculos = result.data;
					// }),
					$scope.updateList(1),
					LancamentoService.getAllLancamentoEstimado().then(function (result) {
						$scope.data.lancamentoEstimados = result.data;
						$scope.data.lancamentoEstimadosByGroup = _.values(_.groupBy(result.data, 'id_grupolancamento'));
					}),
					LancamentoService.mesesAprovadosSemCalculo().then(function (result) {
						$scope.data.meses_aprovados = result.data;
					}),
                    AuthService.aclPaginaService($state.current.name,user.id).then(
                    	result => $scope.accessPagina = result.data)
				]);
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.data = {
			simulacao: {
				dataCalculo: null,
				dataVencimento: null,
				despesaTotal: null,
				formulaAplicada: null,
				lancamentos: []
			},
			simulacaolist: {},
			infoCalculo: {
				area_total: 0,
				total_imoveis: 0,
				tipo_apuracao: "-",
				data_vencimento: "-",
				percentual_juros: 0,
				percentual_multa: 0,
				percentual_fundo_reserva: 0,
				carteira: "-",
				despesa_total: {
					despesas_com_fundo: 0,
					despesas_sem_fundo: 0,
					fundo_reserva: 0
				},
				fracao_ideal: {
					valor_rateio_fundo: 0,
					valor_rateio_m2: 0
				}
			}
		};




		$scope.resetSimulaCalculo = function () {
			LancamentoService.mesesAprovadosSemCalculo().then(function (result) {
				if (result.data.length) {
					$scope.data.meses_aprovados = result.data;
				}
			});
			$scope.data = {
				infoCalculo: {
					area_total: 0,
					total_imoveis: 0,
					tipo_apuracao: "-",
					data_vencimento: "-",
					percentual_juros: 0,
					percentual_multa: 0,
					percentual_fundo_reserva: 0,
					carteira: "-",
					despesa_total: {
						despesas_com_fundo: 0,
						despesas_sem_fundo: 0,
						fundo_reserva: 0
					},
					fracao_ideal: {
						valor_rateio_fundo: 0,
						valor_rateio_m2: 0
					}
				}
			}
		};

		$scope.updateCalculoReceita = function () {
			ReceitaService.getAllCalculoReceita().then(function (result) {
				if (result.data.length) {
					$scope.data.calculos = result.data;
				}
			});
		};

		/*ReceitaService.getInfoCalculoReceita().then(function (result) {
			if (!_.isEmpty(result.data)) {
				$scope.data.infoCalculo = result.data;
			}
		});*/

		$scope.simulaCalculo = function () {
			if (!$scope.data.mesSelecionado) {
				UtilsService.openAlert('Selecione um mês estimado');
				return false;
			}
            if ($scope.data.infoCalculo.area_total === 0){
                UtilsService.openAlertError('Área total para cálculo não foi encontrada!<br>Verifique nos imóveis o cadastro da base de cálculo.');
                return false;
            }
			if ($scope.data.infoCalculo.despesa_total.despesas_com_fundo === 0 && $scope.data.infoCalculo.despesa_total.despesas_sem_fundo === 0 ) {
				UtilsService.openAlert('Informação para o cálculo não carregada, verifique as despesas estimadas para este mês.');
				return false;
			}
			showLoading();
            $scope.data.simulacao = {};
            $scope.data.simulacaolist = {};
            $scope.qtdList = 0;
			ReceitaService.simulaCalculo($scope.data.infoCalculo).then(function (result) {
				if (!result.errors) {
					$scope.data.simulacao.dataCalculo = result.data.data_calculo;
					$scope.data.simulacao.dataVencimento = result.data.data_vencimento;
					$scope.data.simulacao.despesaEstimada = result.data.despesa_estimada;
					$scope.data.simulacao.despesaTotalOutros = result.data.total_outros;
					$scope.data.simulacao.despesaGeralTotal = result.data.total_geral;
					$scope.data.simulacao.fundoDeReserva = result.data.fundo_reserva;
					$scope.data.simulacao.formulaAplicada = result.data.formula_aplicada;
					$scope.data.simulacao.lancamentos = result.data.lancamentos_json;
					$scope.data.simulacaolist.lancamentos = result.data.lancamentos;
					$scope.qtdList = Object.keys($scope.data.simulacaolist.lancamentos).length;
					$scope.continua = false;

					//alertas de áreas diferentes e imoveis sem titular
					var txt = '';
					/*if (parseFloat(result.data.area_imoveis_conflito.area_configurada) !== parseFloat(result.data.area_imoveis_conflito.area_somada)) {
						txt += '<b>- A área total informada no sistema está diferente da área somada dos imóveis, o cálculo do rateio é feito com base na área somada dos imóveis:</b>' +
							'<br>Área informada no sistema: ' + $filter('currency')(result.data.area_imoveis_conflito.area_configurada, '') + 'm²<br>Área somada dos imóveis: ' + $filter('currency')(result.data.area_imoveis_conflito.area_somada, '') + 'm²<br><br>';
					}*/
                    if (Object.keys(result.data.imovel_sem_base_calculo).length > 0) {
                        txt += '<b> Os imóveis abaixo estão sem base de cálculo, favor verificar o cadastro dos imóveis.</b><br>';
                        var obj = result.data.imovel_sem_base_calculo;
                        angular.forEach(obj, function (value, key) {
                            txt += '<br><i style="text-align: left;margin-left: 2%">- '+value.base_calculo+'</i>';
                        });
                        txt += '<br><br>';
                    }
					if (Object.keys(result.data.imovel_sem_titular).length > 0) {
						txt += '<b>- Os imóveis abaixo estão sem titular cadastrado, corriga primeiro antes de simular o cálculo.</b>';
						var obj = result.data.imovel_sem_titular;
						angular.forEach(obj, function (value, key) {
							txt += '<br><i style="text-align: left;margin-left: 2%">- Quadra: ' + value.quadra + ' Lote: ' + value.lote + ' End.: ' + value.logradouro + '</i>';
						});
						txt += '<br><br>';
					}
					if (Object.keys(result.data.cpf_cnpj_invalido).length > 0) {
						txt += '<b>- Os associados abaixo estão com CPF/CNPJ inválido, corriga primeiro antes de simular o cálculo.</b>';
						txt += '<div style="text-align: left;max-height: 307px;overflow-y: auto;">';
						var obj2 = result.data.cpf_cnpj_invalido;
						angular.forEach(obj2, function (value, key) {
							txt += '<br><i>- ' + value.nome + '</i>';
						});
						txt += '</div>';
					}
                    $('#loading').modal('hide');
					if (txt !== '') {
						$scope.modalAlerta = txt;
						$('#modalAlerta').modal('show');
					} else {
                        $('#simulacaoReceita').modal('show');
                    }
				} else {
					UtilsService.openAlert(result.msg);
					$('#loading').modal('hide');
				}
			}).catch(function (error) {
				console.error(error);
				UtilsService.openAlert(error.responseJSON.message);
				$('#loading').modal('hide');
			});
		};

		$scope.print = function () {
		    let conteudo = {
		        'html': $scope.modalAlerta
            };

            $("#waiting").show();
            $http.post(`${config.apiUrl}api/recebimento/print_pendencias_simular_calcular`, conteudo, {
                    responseType: 'arraybuffer'
                })
                .then(result => {
                    let blob = new Blob([result.data], {
                        type: 'application/pdf'
                    });
                    $('#showPdf').modal('show');
                    $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);
                })
                .catch(() => UtilsService.openErrorMsg())
                .finally(() => $("#waiting").hide());
        };

		$scope.aprovaCalculo = function () {
			$scope.btnSimuEna = true;
			showLoading();
			ReceitaService.aprovaCalculo($scope.data.infoCalculo, $scope.data.simulacao)
				.then(function (result) {
					$scope.btnSimuEna = false;
					$('#loading').modal('hide');
					$scope.closeCheckSimulacao();
					$scope.closeSimulacaoModal();
					UtilsService.openSuccessAlert(result.data);
					$scope.updateCalculoReceita();
					$scope.resetSimulaCalculo();

				}).catch(function (error) {
					$('#loading').modal('hide');
					$scope.closeCheckSimulacao();
					$scope.closeSimulacaoModal();
					$scope.btnSimuEna = false;
					UtilsService.openAlert(error.responseJSON.message);
				});
		};

		$scope.downloadRemessa = function (calculo) {
			ReceitaService.downloadRemessa(calculo.id);
		};

        $scope.sendBoletoCalculoEmail = function (calculo) {
            UtilsService.confirmAlert3('Enviar email', 'Deseja enviar os boletos por email?', 'Cancelar', 'Enviar')
                .then(function (confirm) {
                    if (confirm) {
                        showLoading('Enviando', 'aguarde um momento...');
                        ReceitaService.sendBoletoCalculoEmail(calculo.id).then(function () {
                            $('#loading').modal('hide');
                            UtilsService.toastSuccess("Email enviado com sucesso");
                        }).catch(() => {
                            $('#loading').modal('hide');
                            UtilsService.toastError();
                        })
                    } else {
                        UtilsService.toastInfo('Cancelado');
                    }
                });
        };

		$scope.getSumByGroup = function (groupLancamentos) {
			return _.sumBy(groupLancamentos, 'valor');
		};

		$scope.visualizaBoletos = function (calculo) {
			ReceitaService.visualizaBoletos(calculo.id);
		};

		$scope.closeSimulacaoModal = function () {
			$('#simulacaoReceita').modal('hide');
		};

		$scope.checkSimulacao = function () {
			$('#checkSimulacao').modal('show');
		};

		$scope.closeCheckSimulacao = function () {
			$('#checkSimulacao').modal('hide');
		};

		$scope.mesExtenso = (i) => {
			return ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
				"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
			][i - 1];
		};

		$scope.prosseguir = function () {

		};

		$scope.atualizaMesModelo = async function () {
			let mes_ano_modelo = $scope.data.mesSelecionado;
			if (!mes_ano_modelo) {
                $("#simulacao").attr("disabled","disabled");
				$scope.data.infoCalculo.area_total = 0;
				$scope.data.infoCalculo.total_imoveis = 0;
				$scope.data.infoCalculo.tipo_apuracao = "-";
				$scope.data.infoCalculo.data_vencimento = "-";
				$scope.data.infoCalculo.percentual_juros = 0;
				$scope.data.infoCalculo.percentual_multa = 0;
				$scope.data.infoCalculo.percentual_fundo_reserva = 0;
				$scope.data.infoCalculo.carteira = "-";
				$scope.data.infoCalculo.despesa_total.despesas_com_fundo = 0;
				$scope.data.infoCalculo.despesa_total.despesas_sem_fundo = 0;
				$scope.data.infoCalculo.despesa_total.fundo_reserva = 0;
				$scope.data.infoCalculo.fracao_ideal.valor_rateio_fundo = 0;
				$scope.data.infoCalculo.fracao_ideal.valor_rateio_m2 = 0;
				return false;
			}

            $("#simulacao").html('<i class="fa fa-spinner fa-spin"></i> <i class="ba__font-size-8"><b>...carregando</b></i>');
			await ReceitaService.getInfoCalculoReceita(mes_ano_modelo)
				.then( function (result) {
                    if (!_.isEmpty(result.data)) {
                        if (result.data.area_total === 0){
                            UtilsService.openAlertError('Área total para cálculo não foi encontrada!<br>Verifique nos imóveis o cadastro da base de cálculo.');
                            return false;
                        }
                        $scope.data.infoCalculo = result.data;
                        $timeout( function(){
							$("#simulacao").removeAttr("disabled");
							$("#simulacao").html('Simulação');
						}, 500 );
                    } else {
                        UtilsService.openAlertError('Falha ao carregar');
					}
				})
				.catch(function (e) {
					UtilsService.openAlertError(e.responseJSON.message);
                });

			$scope.$digest();
		};

        let showLoading = (title, body) => {

            $scope.loadObj = {
                title: title || 'Calculando',
                body: body || 'Estamos realizando o cálculo da receita. Aguarde um instante...'
            };
            $('#loading').modal('show');
        };

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/receita_calculo?page=${page}`);
			$scope.data.calculos = result.data.data;
			$scope.current_page = result.data.current_page;
			$scope.total = result.data.total;
			$scope.per_page = result.data.per_page;
			$scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
			let pageCount = $scope.pageCount;
			if (pageCount >= 6) {
				if (page > 3 && page < pageCount - 2)
					$scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
				else if (page == pageCount - 1)
					$scope.pages = [page - 4, page - 3, page - 2, page - 1, page];
				else if (page <= 3)
					$scope.pages = [1, 2, 3, 4, 5];
			} else {
				$scope.pages = [];
				for (let i = 1; i <= pageCount; i++) {
					$scope.pages.push(i);
				}
			}
			$scope.$digest();
		}
	}
);