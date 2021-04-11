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

function assembleiaParticipantesCtrl ($scope, $state, $filter,$http, AuthService, UtilsService, config)
{
    $scope.getParticipantes = function ()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/participantes/`+ $state.params.id));
        promisse.then( function (result){
            $scope.listParticipantes = result.data.data;
            angular.forEach($scope.listParticipantes, function(obj) {
                obj.participar = true;
            });
        }).finally( () => {
            $(".loader").hide();
        });
    }

    $scope.getParticipantes();
}