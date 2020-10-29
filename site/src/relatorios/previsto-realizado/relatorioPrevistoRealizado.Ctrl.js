'use strict'
angular.module('RelatoriosModule').controller('RelatorioPrevistoRealizadoCtrl',
	function ($scope, config, $http, UtilsService, HeaderFactory ) {

        HeaderFactory.setHeader('Relatórios', 'previsto x realizado');
        $scope.data = {
			ano: (new Date()).getFullYear()
		};
		$scope.btnGerarRel = (data) => {
            if(!data.mes){
                UtilsService.openAlert('Selecione o MÊS');
				return false;
			}
            if(!data.ano){
                UtilsService.openAlert('Preencha o ANO');
                return false;
            }
			let prom;
            prom = $http.post(`${config.apiUrl}api/relatorios/despesas/previsto_realizado`, data, {
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
					UtilsService.openAlert('Não foi encontrado nenhum resultado!');

				}
			)
		}
	}
);