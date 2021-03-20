'use strict'
angular.module('appDirectives').directive("discussoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/discussoes/discussoes.html',
        controller: discussoesCtrl
    }
});

function discussoesCtrl ($scope, $state, $filter, UtilsService, config)
{

}