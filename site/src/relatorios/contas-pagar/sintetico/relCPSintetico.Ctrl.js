'use strict'
angular.module('RelatoriosModule').controller('RelatorioContasPagarSinteticoCtrl',
	function ($scope, config, $sce, $http, $window, UtilsService, BioacessoService, RelatorioContasPagarSinteticoService, HeaderFactory) {

        HeaderFactory.setHeader('Relatórios', 'Despesas / Sintético');
		$scope.data = {
			data_inicial: '',
			data_final: '',
			data_ini_pgto: '',
			data_fim_pgto: '',
			operacao: ''
		};

		$scope.goToconsultaGeralPdf = function () {
			if ((this.data.data_inicial != '' && this.data.data_final != '') || (this.data.data_ini_pgto != '' && this.data.data_fim_pgto != '')) {
				$('#ModalGeraPdfRelatorio').modal('show');
				var url = config.apiUrl + 'api/relatorios/despesas/contas_a_pagar/sintetico';
				var $promise = $http.post(encodeURI(url), {
					data_inicial: $scope.data.data_inicial,
					data_final: $scope.data.data_final,
					data_ini_pgto: $scope.data.data_ini_pgto,
					data_fim_pgto: $scope.data.data_fim_pgto,
					operacao: $scope.data.operacao,
					header: {
						'Content-Type': 'application/json'
					},
				}, {
					responseType: 'arraybuffer'
				});
				$promise.then(
					function success(response) {
						var blob = new Blob([response.data], {
							type: 'application/pdf'
						});
						var pdfLink = (window.URL || window.webkitURL).createObjectURL(blob);
						window.open(pdfLink, '_blank');
						$('#ModalGeraPdfRelatorio').modal('hide');
					},
					function error(response) {
						$('#ModalGeraPdfRelatorio').modal('hide');
						UtilsService.openAlert('Não foi encontrado nenhum resultado!');
					}
				)
			} else {
				UtilsService.openAlert('Preencha a Data (vencimento / pagamento) inicial e Final.');
			}
		};

		$scope.cancelarOGerarRelatorio = function () {

			$('#ModalGeraPdfRelatorio').modal('hide');
		}

		$scope.goToGerarRelatorio = function () {
			$('#ModalGeraPdfRelatorio').modal('show');
		}
	}
)