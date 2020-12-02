'use strict'
angular.module('ReservasModule').controller('LocalReservavelCtrl',
    function ($scope, UtilsService, HeaderFactory) {

        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
    });