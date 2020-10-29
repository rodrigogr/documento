'use strict'
angular.module('RelatoriosModule').controller('RelatorioInadimplenciaAcordoCtrl',
    function ($scope, config, $http, UtilsService, BioacessoService, $filter, InadimplenciaService, HeaderFactory) {

        HeaderFactory.setHeader('Relatórios', 'inadimplência / acordo');
        $scope.InadimplenciaService = InadimplenciaService;

        $scope.btnGerarRel = (data) => {
            let prom;
            $("#loading").show();
            if (data.consolidados)
                prom = $http.post(`${config.apiUrl}api/relatorios/receitas/acordos_consolidados`, data, {
                    responseType: 'arraybuffer'
                });
            else
                prom = $http.post(`${config.apiUrl}api/relatorios/receitas/acordos`, data, {
                    responseType: 'arraybuffer'
                });
            prom.then(result => {
                let blob = new Blob([result.data], {
                    type: 'application/pdf'
                });
                $('#showPdf').modal('show');
                $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);
            })
                .catch(() => UtilsService.openErrorMsg())
                .finally(() => $("#loading").hide());
        }
    }
);