'use strict'
angular.module('appDirectives').directive("participantes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/participantes/participantes.html',
        controller: participantesCtrl
    }
});

function participantesCtrl ($scope, $state, $filter, UtilsService, config)
{

}