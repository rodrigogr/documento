'use strict'
angular.module('appDirectives').directive("assembleiadiscussoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/discussoes/discussoes.html',
        controller: assembleiaDiscussoesCtrl
    }
});

function assembleiaDiscussoesCtrl ($scope, $state, $filter, UtilsService, config)
{

}