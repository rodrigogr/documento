'use strict'
angular.module('ReservasModule').controller('AprovacaoReservaCtrl',
    function ($scope, UtilsService, HeaderFactory) {

        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
    });