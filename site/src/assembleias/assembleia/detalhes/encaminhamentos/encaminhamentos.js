'use strict'
angular.module('appDirectives').directive("encaminhamentos", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/encaminhamentos/encaminhamentos.html',
        controller: encaminhamentosCtrl
    }
});

function encaminhamentosCtrl ($scope, $state, $filter, UtilsService, config)
{

}