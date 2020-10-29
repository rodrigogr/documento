'use strict'
angular.module('RelatoriosModule').controller('RelatorioInadimplenciaAnaliticoCtrl',
	function ($scope, config, $sce, $http, $window, ConfiguracaoService, UtilsService, BioacessoService, RelatorioInadimplenciaAnaliticoService, HeaderFactory) {

        HeaderFactory.setHeader('Relatórios', 'inadimplência / analítico');
		$scope.data = {
			data_inicial: '',
			data_final: '',
			proprietario: '',
			proprietario_id: '',
			quadra: '',
			lote: '',
			content: ''
		};
        ConfiguracaoService.getAllSituacaoInadimplencia().then(function (result) {
            $scope.data.situacoesInadimplencia = result.data;
        });

		$scope.getImoveisByQuadraAndLoteTituloProvisionado = function () {

			if ($scope.data.quadra != '' && $scope.data.lote != '') {
				$scope.data.proprietario_nome = 'Aguarde... Carregando!';
				$scope.data.proprietario_id = '';

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

		$scope.situacoes = function () {
			ConfiguracaoService.getAllSituacaoInadimplencia().then(function (result) {
				if (result.data.length) {
					$scope.data.situacoesInadimplencia = result.data;
				}
			});
		};

		$scope.gerarPdf = function () {
			if (!$scope.data.situacao_cobranca) {
				$scope.data.situacao_cobranca = "";
			}
			if (this.data.data_inicial != '' && this.data.data_final != '') {

				$('#ModalGeraPdfRelatorio').modal('show');

				var url = config.apiUrl + 'api/relatorios/receitas/inadimplencia_situacao';
				var $promise = $http.post(encodeURI(url), {

					data_inicial: $scope.data.data_inicial,
					data_final: $scope.data.data_final,
					quadra: $scope.data.quadra,
					lote: $scope.data.lote,
					proprietario: $scope.data.proprietario_id,
					situacao_cobranca: $scope.data.situacao_cobranca,
					periodo_congelado: ($scope.data.periodo_congelado ? 1 : 0),

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
						$('#ModalGeraPdfRelatorio').modal('hide');

					},
					function error(response) {
						$('#ModalGeraPdfRelatorio').modal('hide');
						//
						UtilsService.openAlert('Não foi encontrado nenhum resultado!');
					}
				)
			} else {
				UtilsService.openAlert('Preencha a Data inicial e Final.');
			}
		};

		$scope.cancelarOGerarRelatorio = function () {

			$('#ModalGeraPdfRelatorio').modal('hide');
		};

		$scope.goToGerarRelatorio = function () {
			$('#ModalGeraPdfRelatorio').modal('show');
		}
	}
)