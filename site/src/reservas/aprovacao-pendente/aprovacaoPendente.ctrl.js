'use strict'
angular.module('ReservasModule').controller('AprovacaoReservaCtrl',
    function ($scope, $state, UtilsService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);


    });