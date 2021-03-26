'use strict'
angular.module('appDirectives').directive("assembleiaresumo", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/resumo/resumo.html',
        controller: assembleiaResumoCtrl
    }
});

function assembleiaResumoCtrl ($scope, $state, $filter, UtilsService, config)
{

}