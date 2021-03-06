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
    $scope.selecionarTodos = false;

    $scope.getParticipantes = function ()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/participantes/`+ $state.params.id));
        promisse.then( function (result){
            $scope.listParticipantes = result.data.data;
            angular.forEach($scope.listParticipantes, function(obj) {

                obj.participar = !!obj.id_participante;

            });
        }).finally( () => {
            $(".loader").hide();
        });
    }

    $scope.getParticipantes();

    $scope.savePaticipante = function (participante)
    {
        participante.participar = !participante.participar

        var data = {
            id_assembleia: $state.params.id,
            participante : participante
        }

        $("#loading").modal("show");

        $http({
            method: "POST",
            url: `${config.apiUrl}api/assembleias/participantes/salvar`,
            data: data,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            }
        }).then(function(response) {

            participante = response.data.data;

            $scope.listParticipantes.map(function (x){

                if(x.id_imovel === participante.id_imovel)
                {
                    x.id_participante = participante.id_participante;
                }
                return x;
            });

            UtilsService.toastSuccess("Participante Alterado!");

            //$scope.getParticipantes();
        }, function(error) {
            participante.participar = !participante.participar
            UtilsService.openAlert(error.data.message);
        }).finally( () => { $("#loading").modal("hide") });
    }


    $scope.checkSelected = function () {


        $scope.selecionarTodos = !$scope.selecionarTodos ;
        console.log($scope.selecionarTodos );
        //$("#loading").modal("show");
        // angular.forEach($scope.listParticipantes, function(obj) {
        //
        //     obj.participar = false;
        //     //$scope.savePaticipante(obj);
        //
        // });
    }
}