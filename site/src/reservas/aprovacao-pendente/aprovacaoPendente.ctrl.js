'use strict'
angular.module('ReservasModule').controller('AprovacaoPendenteCtrl',
    function ($scope, $state, UtilsService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.contentActive = function(aba) {
            if (aba == 1) {

            } else {

            }
        }
    });