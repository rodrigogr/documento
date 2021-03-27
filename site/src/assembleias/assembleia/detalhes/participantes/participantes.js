'use strict'
angular.module('appDirectives').directive("assembleiaparticipantes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/participantes/participantes.html',
        controller: assembleiaParticipantesCtrl
    }
});

function assembleiaParticipantesCtrl ($scope, $state, $filter, UtilsService, config)
{

}