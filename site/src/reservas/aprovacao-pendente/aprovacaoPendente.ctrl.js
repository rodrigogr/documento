'use strict'
angular.module('ReservasModule').controller('AprovacaoPendenteCtrl',
    function ($scope, $http, $state, UtilsService, HeaderFactory, AuthService, config) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        moment.locale('pt-br');

        $scope.contentActive = function(aba) {
            if (aba == 1) {

            } else {

            }
        }

        async function getAllLocaisReservaveis() {
            $scope.loadLocais = false;
            let result = await $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`).finally(() => $scope.loadLocais = true);
            $scope.locaisReservaveis = result.data.data;
        }
        getAllLocaisReservaveis();

        $http.get(`${config.apiUrl}api/aprovacao/pendentes/hoje`).then( function (result) {
            $scope.loadDiaPendente = true;
            $scope.pendentes = result.data.data;
            $scope.topicoData = {
                dia: moment().format('D'),
                mes: moment().format('MMMM'),
                semana: moment().format('dddd')
            }
        }).finally( () => $scope.loadDiaPendente = false);

    });