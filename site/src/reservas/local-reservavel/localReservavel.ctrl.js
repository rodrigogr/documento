'use strict'
angular.module('ReservasModule').controller('LocalReservavelCtrl',
    function ($scope, $state, HeaderFactory, AuthService) {
        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.createNovoLocal = function () {
            $scope.step = 1;
            $('#cadastroLocal').modal('show');
        }

    });