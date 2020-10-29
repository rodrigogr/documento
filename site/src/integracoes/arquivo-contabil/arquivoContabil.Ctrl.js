'use strict'
angular.module('IntegracoesModules').controller('ArqContabilCtrl',
	function ($scope, $http, config, UtilsService, HeaderFactory) {

        HeaderFactory.setHeader('integrações', 'arquivo contábil');
        $scope.ngOnInit = () => {
        	$scope.dados_ini();
        };
        $scope.dados_ini = () => {
            $scope.data = {
                nome: '',
                data_inicial: null,
                data_final: null,
                tipo: '',
                quadra: '',
                lote: '',
                code_emp: '',
                cod_nor_cont_credito: '',
                cod_nor_cont_debito: '',
                codigo_agrupador: ''
            };
        };
        $scope.exportar = () => {
            if ($scope.data.nome === '' || !$scope.data.tipo || $scope.data.code_emp === ''
                || $scope.data.cod_nor_cont_credito === '' || $scope.data.cod_nor_cont_debito === '' || $scope.data.codigo_agrupador === '' ) {
                UtilsService.toastError('Verifique os campos obrigatórios');
                return false;
            }
            if ($scope.data.data_inicial !== null || $scope.data.data_final !== null) {
                if ($scope.data.data_inicial !== null && $scope.data.data_final !== null) {}
                else {
                    UtilsService.toastError('Para filtrar por Período, deve ser preenchido data inicial e final');
                    return false;
                }
            }
            if ($scope.data.quadra !== "" || $scope.data.lote !== '') {
                if ($scope.data.quadra !== '' && $scope.data.lote !== '') {}
                else {
                    UtilsService.toastError('Para filtrar por Quadra e Lote, os dois campos devem estar preenchidos');
                    return false;
                }
            }
            $("#loading").modal('show');
            var url = config.apiUrl + 'api/exporta_arquivo_contabil';
            var $promise = $http.post(encodeURI(url),  {
                data: $scope.data,
                header: {
                    'Content-Type': 'application/json'
                }
            }, {
                responseType: 'arraybuffer'
            });

            $promise.then( function success(response) {
                var blob = new Blob([response.data], {
                    type: 'text/csv'
                });
                var csvLink = (window.URL || window.webkitURL).createObjectURL(blob);
                var a = $('<a/>', {
                        style:'display:none',
                        href:csvLink,
                        download:$scope.data.nome+'.csv'
                    }).appendTo('body');
                    a[0].click();
                    a.remove();
                }, function error(response) {
                    UtilsService.openAlert('Não foi encontrado nenhum resultado!');
                }
            ).finally(()=>{
                $("#loading").modal('hide');
                $scope.dados_ini();
            })
        }
	}
);