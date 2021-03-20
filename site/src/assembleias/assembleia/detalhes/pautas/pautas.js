'use strict'
angular.module('appDirectives').directive("pautas", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/pautas/pautas.html',
        controller: pautasCtrl
    }
});

function pautasCtrl ($scope, $state, $filter, UtilsService, config)
{

}