'use strict'
angular.module('ReservaModules').controller('LocalReservavelCtrl',
    function ($scope, UtilsService, EnvioEmailService, HeaderFactory) {

        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
    });