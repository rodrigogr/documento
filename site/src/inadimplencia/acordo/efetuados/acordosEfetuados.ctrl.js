'use strict'
angular.module('InadimplanciaModule')
	.controller('acordosEfetuadosCtrl',
		function ($scope, config, $filter, $http, UtilsService, BioacessoService, InadimplenciaService, HeaderFactory) {

            HeaderFactory.setHeader('inadimplência', 'acordo / efetuados');
			$scope.InadimplenciaService = InadimplenciaService;
			$scope.titulosList;
			$scope.detalheAcordo;
			$scope.acordoSelecionado;

			$scope.selectAcordo = (id) => {
				InadimplenciaService.getAcordoById(id)
					.then(result => {
						$scope.detalheAcordo = result;
						$scope.$digest();
					})
			};

			$scope.cancelarAcordo = (motivoCancel) => {
				let data = {
					"id": $scope.acordoSelecionado.id,
					"descricao": motivoCancel
				};
				InadimplenciaService.postCancelarAcordo(data)
					.then(result => {
						$('#cancelarAcordo').modal('hide');
						if (result.erros) {
							UtilsService.toastError(result.data);
						} else {
							UtilsService.toastSuccess(result.data);
							$scope.pesquisar($scope.search);
						}
					}).catch((e) => {
						UtilsService.toastError(e.data.message);
						$('#cancelarAcordo').modal('hide');
					})
			};

			$scope.visualizaBoleto = function (id) {
                let prom;
                prom = $http.get(`${config.apiUrl}api/inadimplencia/acordos_efetuados/boleto/`+id, {
                    responseType: 'arraybuffer'
                });
                prom.then(
                    function success(response) {
                        let blob = new Blob([response.data], {
                            type: 'application/pdf'
                        });

                        $('#showPdf').modal('show');
                        $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);

                    }, function error(e) {
                        UtilsService.toastError(e || 'Não foi encontrado nenhum resultado!');

                    }
                )
			};


			$scope.enviaBoleto = (id) => {
				$('#loading').modal('show');
				InadimplenciaService.enviaBoletoEmail(id)
					.then(result => {
						$('#loading').modal('hide');
						UtilsService.openSuccessAlert(result.data);
					})
			}

			$scope.downloadRemessa = function (id) {
                $('#loading-gerar_remessa').modal('show');
                $http.get(config.apiUrl + 'api/inadimplencia/acordos_efetuados/remessa/' + id)
                    .then( function (response) {
                        $('#loading-gerar_remessa').modal('hide');
                        window.open(config.apiUrl + 'api/inadimplencia/acordos_efetuados/remessa/' + id);
                    })
                    .catch( function (e) {
                        $('#loading-gerar_remessa').modal('hide');
                        UtilsService.openAlert(e.data.message);
                    })
			};

			$scope.pesquisar = async(search) => {
				try {
					$('.loader').show();
					let result = await $http.post(`${config.apiUrl}api/inadimplencia/acordos_efetuados/filtro`, search);
					$scope.titulosList = result.data;
					$scope.$digest();
				} catch (e) {
					UtilsService.toastInfo(e.data.message);
				} finally {
					$('.loader').hide();
				}
			}

			$scope.openModal = (evt, id, acordo) => {
				/*if(acordo.status ==0){
					UtilsService.toastInfo('Acordo já cancelado!');
				} else {*/
                    $scope.acordoSelecionado = acordo;
                    $(id).modal('show');
                    evt.stopPropagation();
				// }
			};

			$scope.valorMulta = () => {
				if (!$scope.detalheAcordo) return 0;
				let multaFilter = x => x.lancamento.categoria == 5;
				return $scope.detalheAcordo.recebimento_acordo.lancamentos.find(multaFilter).lancamento.valor;
			};

			$scope.valorJuros = () => {
				if (!$scope.detalheAcordo) return 0;
				let jurosFilter = x => x.lancamento.categoria == 6;
				return $scope.detalheAcordo.recebimento_acordo.lancamentos.find(jurosFilter).lancamento.valor;
			};

			$scope.valorCustosAdd = () => {
				try {
					if (!$scope.detalheAcordo) return 0;
					let custosFilter = x => x.lancamento.categoria != 1 && x.lancamento.categoria != 2 && x.lancamento.categoria != 5 && x.lancamento.categoria != 6 && x.lancamento.categoria != 7 && x.lancamento.categoria != 10 ;
					return $scope.detalheAcordo.recebimento_acordo.lancamentos.filter(custosFilter).map(x => x.lancamento.valor).reduce((x, y) => x + y);
				} catch (e) {
					return 0;
				}
			};

			$scope.valorDescontos = () => {
				try {
					if (!$scope.detalheAcordo) return 0;
					let descontoFilter = x => x.lancamento.categoria === 7;
					let valor_entrada = $scope.detalheAcordo.valor_entrada;
					let descontos = $scope.detalheAcordo.recebimento_acordo.lancamentos.filter(descontoFilter).map(x => x.lancamento.valor).reduce((x, y) => x + y);
					return valor_entrada ? descontos+valor_entrada : descontos;
				} catch (e) {
					return 0;
				}
			};

			$scope.formatDate = (date) => {
				return new Date(date.toString());
			}

		}
	);