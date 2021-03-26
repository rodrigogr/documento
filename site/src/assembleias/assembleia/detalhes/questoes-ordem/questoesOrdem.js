'use strict'
angular.module('appDirectives').directive("assembleiaquestoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/questoes-ordem/questoesOrdem.html',
        controller: assembleiaQuestoesOrdemCtrl
    }
});

function assembleiaQuestoesOrdemCtrl ($scope, $state, $filter, UtilsService, config)
{

}