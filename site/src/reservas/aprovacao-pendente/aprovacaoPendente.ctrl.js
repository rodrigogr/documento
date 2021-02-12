'use strict'
angular.module('ReservasModule').controller('AprovacaoPendenteCtrl',
    function ($scope, $http, $state, UtilsService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.contentActive = function(aba) {
            if (aba == 1) {

            } else {

            }
        }

        async function getAllLocaisReservaveis() {
            let result = await $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`);
            $scope.pendentes = result.data.data;
        }
        getAllLocaisReservaveis();
    });