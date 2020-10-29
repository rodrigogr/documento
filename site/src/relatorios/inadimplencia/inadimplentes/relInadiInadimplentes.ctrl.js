'use strict'
angular.module('RelatoriosModule').controller('RelatorioInadimplentesCtrl',
	function ($scope, config, $sce, $http, $window, ConfiguracaoService, UtilsService, BioacessoService, RelatorioInadimplentesService, HeaderFactory) {

        HeaderFactory.setHeader('Relatórios', 'inadimplência / inadimplentes');
		$scope.data = {
			data_inicial: '',
			data_final: '',
			quadra: '',
			lote: '',
			content: '',
			situacao_cobranca: '',
            somente_taxas: false,
            competencia: ''

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

		$scope.goToconsultaGeralPdf = function () {

			if (!$scope.data.somente_taxas) {
                if (this.data.data_inicial == '' && this.data.data_final == '') {
                    UtilsService.openAlert('Preencha a Data inicial e Final.');
                    return;
                }
            }
            if ($scope.data.somente_taxas && !$scope.data.competencia) {
                UtilsService.openAlert('Preencha a Competência.');
                return;
            }

            let data_ini = $scope.data.data_inicial ? $scope.data.data_inicial.toLocaleDateString() : '';
            let data_fim = $scope.data.data_final ? $scope.data.data_final.toLocaleDateString() : '';

			$('#geraTitulosProvisionados').modal('show');

			var url = config.apiUrl + 'api/relatorios/receitas/inadimplencia';

			var $promise = $http.post(encodeURI(url), {

				data_inicial: data_ini,
				data_final: data_fim,
				quadra: $scope.data.quadra,
				lote: $scope.data.lote,
				situacao_cobranca: $scope.data.situacao_cobranca,
				periodo_congelado: ($scope.data.periodo_congelado ? 1 : 0),
                somente_taxas: $scope.data.somente_taxas,
                competencia: $scope.data.competencia,
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
					$('#geraTitulosProvisionados').modal('hide');
				},
				function error(response) {
					$('#geraTitulosProvisionados').modal('hide');
					UtilsService.openAlert('Não foi encontrado nenhum resultado!');

				}
			)
		};



		$scope.cancelarOGerarRelatorio = function () {

			$('#geraTitulosProvisionados').modal('hide');
		}

		$scope.goToGerarRelatorio = function () {
			$('#geraTitulosProvisionados').modal('show');
		}



	}
)