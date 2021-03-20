'use strict'
angular.module('appDirectives').directive("questoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/questoes-ordem/questoesOrdem.html',
        controller: questoesOrdemCtrl
    }
});

function questoesOrdemCtrl ($scope, $state, $filter, UtilsService, config)
{

}