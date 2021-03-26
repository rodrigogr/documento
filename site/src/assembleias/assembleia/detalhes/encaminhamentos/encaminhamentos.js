'use strict'
angular.module('appDirectives').directive("assembleiaencaminhamentos", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/encaminhamentos/encaminhamentos.html',
        controller: assembleiaEncaminhamentosCtrl
    }
});

function assembleiaEncaminhamentosCtrl ($scope, $state, $filter, UtilsService, config)
{

}