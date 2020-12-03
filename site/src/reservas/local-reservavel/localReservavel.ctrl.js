'use strict'
angular.module('ReservasModule').controller('LocalReservavelCtrl',
    function ($scope, HeaderFactory, AuthService) {
        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
        let acessoUsuario = AuthService.getAcessosUsuario();
        $scope.permissaoReservaLocal = acessoUsuario.filter()
    });