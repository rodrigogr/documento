'use strict'
angular.module('ReservasModule').controller('CalendarioReservaCtrl',
    function ($scope, UtilsService, HeaderFactory) {

        HeaderFactory.setHeader('reservas', 'Calendário de reservas');
    });