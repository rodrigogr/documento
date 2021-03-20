'use strict'
angular.module('appDirectives').directive("resumo", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/resumo/resumo.html',
        controller: headerCtrl
    }
});

function resumoCtrl ($scope, $state, $filter, UtilsService, config)
{

}