'use strict'
angular.module('ContasPagarModule').controller('LancamentoAprovadoDetalheCtrl',
	function ($scope, $http, config, $stateParams, HeaderFactory, UtilsService) {

        HeaderFactory.setHeader('Despesas', 'lançamentos estimados / detalhes');

		$scope.ngOnInit = async () => {
			try {
				$('.loader').show();
				let result = await this.getLancamento($stateParams.mes, $stateParams.ano);
				$scope.resumoLancamentosEstimados = result.data;
				$scope.Itens = _.values(_.groupBy(result.data.estimados, 'id_grupolancamento'));
				$scope.$digest();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		$scope.getTitle = () => `${this.mesExtenso($stateParams.mes)} de ${$stateParams.ano}` || '';

		// $scope.pdfUrl = () => `${config.apiUrl}api/estimados/pdf/${$stateParams.mes}/${$stateParams.ano}`;
        $scope.pdfUrl = function () {
            let prom;
            prom = $http.get(`${config.apiUrl}api/estimados/pdf/${$stateParams.mes}/${$stateParams.ano}`, {
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


		this.getLancamento = (mes, ano) => $http.get(`${config.apiUrl}api/estimados/${mes}/${ano}`);

		this.mesExtenso = (i) => ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"][i - 1];

		$scope.totalByGroup = (x) => x.map(c => c.valor).reduce((x, y) => x + y);
	}
);