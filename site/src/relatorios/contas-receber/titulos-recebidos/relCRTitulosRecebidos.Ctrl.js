'use strict'
angular.module('RelatoriosModule').controller('TitulosRecebidosRelatorioCtrl',
	function ($scope, config, $sce, $http, $window, UtilsService, BioacessoService, TitulosRecebidosRelatorioService, HeaderFactory) {

        HeaderFactory.setHeader('Relatórios', 'Receitas / títulos recebidos');
		$scope.data = {
			data_inicial: '',
			data_final: '',
			data_pgto_inicial: '',
			data_pgto_final: '',
			proprietario: '',
			quadra: '',
			lote: '',
			lancamentoAvulso: 'ambos',
			content: ''
		};
		$scope.getImoveisByQuadraAndLoteTituloProvisionado = function () {

			if ($scope.data.quadra != '' && $scope.data.lote != '') {
				$scope.data.proprietario_nome = 'Aguarde... Carregando!';

				BioacessoService.getImoveisByQuadraAndLote($scope.data.quadra, $scope.data.lote).then(function (result) {
					if (_.isArray(result.data)) {

						$scope.data.proprietario_id = _.first(result.data).pessoa_id;
						$scope.data.proprietario_nome = _.first(result.data).nome;
					} else {

						$scope.data.proprietario_nome = '';
						UtilsService.openAlert(result.data);
					}
				});
			} else {
				$scope.data.proprietario_id = '';
				$scope.data.proprietario_nome = '';
			}
		};

		$scope.goToconsultaPdfTitulosRecebidos = function () {

			//this.data.data_inicial != '' && this.data.data_final != ''
			if ((this.data.data_inicial != '' && this.data.data_final != '') || (this.data.data_pgto_inicial != '' && this.data.data_pgto_final != '')) {

				$('#geraTitulosProvisionados').modal('show');

				var url = config.apiUrl + 'api/relatorios/receitas/titulos_recebidos';
				var $promise = $http.post(encodeURI(url), {

					data_inicial: $scope.data.data_inicial,
					data_final: $scope.data.data_final,
					data_pgto_inicial: $scope.data.data_pgto_inicial,
					data_pgto_final: $scope.data.data_pgto_final,
					quadra: $scope.data.quadra,
					lote: $scope.data.lote,
					proprietario: $scope.data.proprietario_id,
					lancamentoAvulso: $scope.data.lancamentoAvulso,

					header: {
						'Content-Type': 'application/json'
					}
				}, {
					responseType: 'arraybuffer'
				});

				$promise.then(

					function success(response) {
						var blob = new Blob([response.data], {
							type: 'application/pdf'
						});
						var pdfLink = (window.URL || window.webkitURL).createObjectURL(blob);

						window.open(
							pdfLink,
							'_blank' // <- This is what makes it open in a new window.
						);

						//cb(pdfLink);
						$('#geraTitulosProvisionados').modal('hide');

					},
					function error(response) {
						$('#geraTitulosProvisionados').modal('hide');
						//
						UtilsService.openAlert('Não foi encontrado nenhum resultado!');

					}
				)
			} else {
				UtilsService.openAlert('Preencha a Data (vencimento / pagamento) inicial e Final.');
			}
		};
		$scope.cancelarOGerarRelatorio = function () {

			$('#geraTitulosProvisionados').modal('hide');
		}
		$scope.goToGerarRelatorio = function () {
			$('#geraTitulosProvisionados').modal('show');
		}
	}
)